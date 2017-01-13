;;; ydk-mode.el --- Language support for Yu-Gi-Oh! deck files -*- lexical-binding: t; -*-

;; Copyright (C) 2017 Jackson Ray Hamilton

;; Author: Jackson Ray Hamilton <jackson@jacksonrayhamilton.com>
;; Version: 1.0.0
;; Keywords: faces games languages ydk yugioh yu-gi-oh
;; URL: https://github.com/jacksonrayhamilton/ydk-mode

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides language support for Yu-Gi-Oh! deck files.  These typically have a
;; ".ydk" extension.  They are used in YGOPro and other dueling simulators.

;; YDK files consist of lists of newline-delimited integers.  These integers
;; correspond to the 8-digit "passcodes" unique to each card. (See
;; http://yugioh.wikia.com/wiki/Passcode for details.)  Each newline-delimited
;; integer represents one copy of a corresponding card in a deck.

;; Comments may appear anywhere in a file, starting with "#" or "!", followed by
;; (usually) arbitrary characters, ending with a newline.

;; There are three "magic" comments which typically denote the beginning of a
;; new deck (that is, the Main Deck, Extra Deck or Side Deck).  Conventionally,
;; these magic comments are of the forms:

;;     #main
;;     #extra
;;     !side

;; The magic comments are highlighted specially in this mode to make them more
;; distinguishable.

;; Putting it all together, a YDK file specifying a deck,

;; - created by someone named Jackson
;; - with the following cards in his Main Deck:
;;   - 3x Blue-Eyes White Dragon
;;   - 1x Lord of D.
;;   - 1x The Flute of Summoning Dragon
;; - and this card in his Extra Deck:
;;   - 1x Blue-Eyes Ultimate Dragon
;; - and this card in his Side Deck:
;;   - 1x Cipher Soldier

;; would look something like this:

;;     #created by Jackson
;;     #main
;;     89631139
;;     89631139
;;     89631139
;;     17985575
;;     43973174
;;     #extra
;;     23995346
;;     !side
;;     79853073

;; To use this mode, simply add the following to your init file, and ".ydk"
;; files you open will be colored syntactically:

;;     (require 'ydk-mode)

;;; Code:

(defvar ydk-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?# "<" table)
    (modify-syntax-entry ?! "<" table)
    (modify-syntax-entry ?\n ">" table)
    table)
  "Syntax table to use in YDK mode.")

(defvar ydk-mode-font-lock-keywords
  '(("^\\(?:#\\|!\\)\\(main\\|extra\\|side\\)$" 1 font-lock-warning-face prepend))
  "Highlighting keywords for YDK mode.")

;;;###autoload
(define-derived-mode ydk-mode text-mode "YDK"
  "Major mode for editing Yu-Gi-Oh! deck files."
  (setq-local comment-start "# ")
  (setq-local comment-end "")
  (setq-local font-lock-defaults '(ydk-mode-font-lock-keywords)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ydk\\'" . ydk-mode))

(provide 'ydk-mode)

;;; ydk-mode.el ends here
