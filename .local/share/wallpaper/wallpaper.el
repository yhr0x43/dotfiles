(require 'xml)

(defun product (xs ys)
  (mapcan (lambda (x) (mapcar (lambda (y) (cons x y)) ys)) xs))

(setq ctrl-chars
      [ "NUL" "SOH" "STX" "ETX" "EOT" "ENQ" "ACK" "BEL"
        "BS"  "HT"  "LF"  "VT"  "FF"  "CR"  "SO"  "SI"
        "DLE" "DC1" "DC2" "DC3" "DC4" "NAK" "SYN" "ETB"
        "CAN" "EM"  "SUB" "ESC" "FS"  "GS"  "RS"  "US"
        "SP"])

(defun byte-to-label (byte)
  (when (or (< byte 0) (> byte #x7f)) (error "invalid byte to encode"))
  (cond ((<= byte #x20) (aref ctrl-chars byte))
        ((< byte #x7f) (byte-to-string byte))
        (t "DEL")))

(defun ascii-table-render (ascii-table-dom &optional offset-x offset-y)
  ;; numbers are picked with an assumption that each glyph occupy area smaller than 36x48
  (let ((offset-x (if offset-x offset-x 0))
        (offset-y (if offset-y offset-y 0))
        (grid-x 84)
        (grid-y 48))
    ;; ASCII labels in a grid
    (let ((content-dom (dom-by-id ascii-table-dom "^ascii-content$")))
      (dolist
          (elmdom (mapcar
                   (lambda (val)
                     (let ((x (car val))
                           (y (cdr val)))
                       `(text ((x . ,(number-to-string (+ offset-x (* x grid-x) grid-x)))
                               (y . ,(number-to-string (+ offset-y (* y grid-y) (* 2 grid-y)))))
                              ,(byte-to-label (+ y (* x 16))))))
                   (product (number-sequence 0 7) (number-sequence 0 15))))
        (dom-append-child content-dom elmdom)))
    ;; Headers
    (let ((header-dom (dom-by-id ascii-table-dom "^ascii-header$")))
      (dolist (x (number-sequence 0 7))
        (dom-append-child header-dom
                          `(text ((x . ,(number-to-string (+ offset-x (* grid-x (1+ x)))))
                                  (y . ,(number-to-string (+ offset-y grid-y))))
                                 ,(number-to-string x))))
      (dolist (y (number-sequence 0 15))
        (dom-append-child header-dom
                          `(text ((x . ,(number-to-string (+ offset-x 16)))
                                  (y . ,(number-to-string (+ offset-y (* grid-y (+ 2 y))))))
                                 ,(format "%X" y)))))
    ;; Lines
    (let ((lines-dom (dom-by-id ascii-table-dom "^ascii-table-lines$")))
      (dom-append-child lines-dom
                        `(rect ((x . ,(number-to-string (+ offset-x 36)))
                                (y . ,(number-to-string (+ offset-y 12)))
                                (width . "4")
                                (height . ,(number-to-string (* 17 grid-y)))
                                (rx . "2")
                                (ry . "2"))
                               nil))
      (dom-append-child lines-dom
                        `(rect ((x . ,(number-to-string offset-x))
                                (y . ,(number-to-string (+ offset-y 56)))
                                (width . ,(number-to-string (* 8.5 grid-x)))
                                (height . "4")
                                (rx . "2")
                                (ry . "2"))
                               nil)))))

(defun power-of-two-render (power-of-two-dom &optional offset-x offset-y)
  (let ((offset-x (if offset-x offset-x 0))
        (offset-y (if offset-y offset-y 0))
        (start-i 8)
        (grid-y 32))
    (dolist (i (number-sequence start-i 64))
      (if (= 0 (mod i 5))
          (progn (dom-append-child power-of-two-dom
                                   `(text ((x . ,(number-to-string offset-x))
                                           (y . ,(number-to-string (+ offset-y (* (- i start-i) grid-y)))))
                                          ,(format "%2d" i)))
                 (dom-append-child power-of-two-dom
                                   `(rect ((x . ,(number-to-string (+ offset-x 40)))
                                           (y . ,(number-to-string (+ offset-y (* (- i start-i 0.3) grid-y))))
                                           (width . "15")
                                           (height . "2")
                                           (rx . "1")
                                           (ry . "2"))
                                          nil)))
        (dom-append-child power-of-two-dom
                          `(circle ((cx . ,(number-to-string (+ offset-x 20)))
                                    (cy . ,(number-to-string (+ offset-y (* (- i start-i 0.2) grid-y))))
                                    (r . "2"))
                                   nil)))
      (dom-append-child power-of-two-dom
                        `(text ((x . ,(number-to-string (+ offset-x 60)))
                                (y . ,(number-to-string (+ offset-y (* (- i start-i) grid-y)))))
                               ,(number-to-string (expt 2 i)))))))

(defun pascal-triangle-render (pascal-triagnel-dom &optional offset-x offset-y)
  )

(defun rust-op-precedence-render (op-precedence-dom &optional offset-x offset-y)
  (let ((offset-x (if offset-x offset-x 0))
        (offset-y (if offset-y offset-y 0))
        (grid-x 18) ; estimation of char width
        (grid-y 32)
        (op-list '(("?")
                   ("unary -" "!" "*" "borrow")
                   ("as")
                   ("*" "/" "%")
                   ("+" "-")
                   ("<<" ">>")
                   ("&")
                   ("^")
                   ("|")
                   ("==" "!=" "<" ">" "<=" ">=")
                   ("&&")
                   ("||")
                   (".." "..=")
                   ("=" "+=" "-=" "*=" "/=" "%=" "&=" "|=" "^=" "<<=" ">>="))))
    (setq dy 0)
    (dolist (line op-list)
      (setq dx 0)
      (dolist (op line)
        (let ((op-x (+ offset-x (* grid-x dx)))
              (op-y (+ offset-y (* grid-y dy))))
          (dom-append-child op-precedence-dom
                            `(rect ((x . ,(number-to-string op-x))
                                    (y . ,(number-to-string (- op-y grid-y -7)))
                                    (width . ,(number-to-string (* (length op) grid-x)))
                                    (height . ,(number-to-string grid-y))
                                    (fill . "#0d0d0d")
                                    (rx . "4"))))
          (dom-append-child op-precedence-dom
                          `(text ((x . ,(number-to-string op-x))
                                  (y . ,(number-to-string op-y)))
                                 ,(concat op " "))))
        (setq dx (+ dx (length op) 1)))
      (setq dy (1+ dy)))))

(with-temp-file "wallpaper.svg"
  (let ((document-dom (xml-parse-file "wallpaper-proto.svg")))
    (ascii-table-render (dom-by-id document-dom "^ascii-table$") 2150 50)
    (power-of-two-render (dom-by-id document-dom "^power-of-two$") 10 75)
    (rust-op-precedence-render (dom-by-id document-dom "^rust-op-precedence$") 2150 1000)
    (dom-print document-dom t t)))
(unless (and
         (call-process "magick" nil nil nil  "wallpaper.svg" "wallpaper.png")
         (call-process "systemctl" nil nil nil "--user" "restart" "hyprpaper.service"))
  (error "wallpaper rebuild command failed"))
