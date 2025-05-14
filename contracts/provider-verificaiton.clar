;; Provider Verification Contract
;; Validates healthcare practitioners

(define-data-var admin principal tx-sender)

;; Provider status: 0 = unverified, 1 = verified, 2 = suspended
(define-map providers
  { provider-id: (string-ascii 64) }
  {
    principal: principal,
    status: uint,
    verification-date: uint,
    license-number: (string-ascii 64),
    license-state: (string-ascii 2)
  }
)

;; Add a new provider
(define-public (register-provider (provider-id (string-ascii 64)) (license-number (string-ascii 64)) (license-state (string-ascii 2)))
  (let ((caller tx-sender))
    (if (map-insert providers
                    { provider-id: provider-id }
                    {
                      principal: caller,
                      status: u0,
                      verification-date: u0,
                      license-number: license-number,
                      license-state: license-state
                    })
        (ok true)
        (err u1) ;; Provider ID already exists
    )
  )
)

;; Verify a provider (admin only)
(define-public (verify-provider (provider-id (string-ascii 64)))
  (let ((caller tx-sender))
    (if (is-eq caller (var-get admin))
        (match (map-get? providers { provider-id: provider-id })
          provider (begin
            (map-set providers
                     { provider-id: provider-id }
                     (merge provider {
                       status: u1,
                       verification-date: block-height
                     }))
            (ok true)
          )
          (err u2) ;; Provider not found
        )
        (err u3) ;; Not authorized
    )
  )
)

;; Suspend a provider (admin only)
(define-public (suspend-provider (provider-id (string-ascii 64)))
  (let ((caller tx-sender))
    (if (is-eq caller (var-get admin))
        (match (map-get? providers { provider-id: provider-id })
          provider (begin
            (map-set providers
                     { provider-id: provider-id }
                     (merge provider { status: u2 }))
            (ok true)
          )
          (err u2) ;; Provider not found
        )
        (err u3) ;; Not authorized
    )
  )
)

;; Get provider information
(define-read-only (get-provider (provider-id (string-ascii 64)))
  (map-get? providers { provider-id: provider-id })
)

;; Check if provider is verified
(define-read-only (is-verified (provider-id (string-ascii 64)))
  (match (map-get? providers { provider-id: provider-id })
    provider (is-eq (get status provider) u1)
    false
  )
)

;; Transfer admin rights
(define-public (set-admin (new-admin principal))
  (let ((caller tx-sender))
    (if (is-eq caller (var-get admin))
        (begin
          (var-set admin new-admin)
          (ok true)
        )
        (err u3) ;; Not authorized
    )
  )
)
