; Regular expressions on input strings of length 2, per Kim et al. 2021.
; The input is encoded as a sequence of integers s_0, ... s_n.

;; (set-info :format-version "2.0.0")
;; (set-info :author("Wiley Corning"))

(declare-term-types
    ;; Nonterminals
    ((Start 0) (R 0))
    
    ;; Productions
    (
        (($eval R))
    
        (
            ($eps)
            ($phi)
            ($char_1)
            ($char_2)
            ($any)
            ($neg R)
            ($or R R)
            ($concat R R)
            ($star R)
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start) (s_0 Int) (s_1 Int) (result Bool)) Bool)
        (R.Sem ((t R) (s_0 Int) (s_1 Int) (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_1_1 Bool) (X_1_2 Bool) (X_2_2 Bool)) Bool)
    )
    
    (
        (! (match t (
            (($eval t1) (exists
                ((X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_1_1 Bool) (X_1_2 Bool) (X_2_2 Bool))
                (and
                    (R.Sem t1 s_0 s_1 X_0_0 X_0_1 X_0_2 X_1_1 X_1_2 X_2_2)
                    (= result X_0_2)
                )
            ))
        )) :input (s_0 s_1) :output (result))
        (! (match t (
            ($eps (and (= X_0_0 true) (= X_0_1 false) (= X_0_2 false) (= X_1_1 true) (= X_1_2 false) (= X_2_2 true)))
            ($phi (and (= X_0_0 false) (= X_0_1 false) (= X_0_2 false) (= X_1_1 false) (= X_1_2 false) (= X_2_2 false)))
            ($char_1 (and (= X_0_0 false) (= X_0_1 (= s_0 1)) (= X_0_2 false) (= X_1_1 false) (= X_1_2 (= s_1 1)) (= X_2_2 false)) )
            ($char_2 (and (= X_0_0 false) (= X_0_1 (= s_0 2)) (= X_0_2 false) (= X_1_1 false) (= X_1_2 (= s_1 2)) (= X_2_2 false)) )
            ($any (and (= X_0_0 false) (= X_0_1 (> s_0 0)) (= X_0_2 false) (= X_1_1 false) (= X_1_2 (> s_1 0)) (= X_2_2 false)))
            (($neg t1)
                (exists
                    (
                        (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_2_2 Bool)
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 A_0_0 A_0_1 A_0_2 A_1_1 A_1_2 A_2_2)
                        (and 
                            (= X_0_0 (not A_0_0)) 
                            (= X_0_1 (not A_0_1)) 
                            (= X_0_2 (not A_0_2)) 
                            (= X_1_1 (not A_1_1)) 
                            (= X_1_2 (not A_1_2)) 
                            (= X_2_2 (not A_2_2)) 
                        )
                    )
                )
            )
            (($or t1 t2)
                (exists
                    (
                        (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_2_2 Bool)
                        (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_1_1 Bool) (B_1_2 Bool) (B_2_2 Bool)
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 A_0_0 A_0_1 A_0_2 A_1_1 A_1_2 A_2_2)
                        (R.Sem t2 s_0 s_1 B_0_0 B_0_1 B_0_2 B_1_1 B_1_2 B_2_2)
                        (and 
                            (= X_0_0 (or A_0_0 B_0_0))
                            (= X_0_1 (or A_0_1 B_0_1))
                            (= X_0_2 (or A_0_2 B_0_2))
                            (= X_1_1 (or A_1_1 B_1_1))
                            (= X_1_2 (or A_1_2 B_1_2))
                            (= X_2_2 (or A_2_2 B_2_2))
                        )
                    )
                )
            )
            (($concat t1 t2)
                (exists
                    (
                        (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_2_2 Bool)
                        (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_1_1 Bool) (B_1_2 Bool) (B_2_2 Bool)
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 A_0_0 A_0_1 A_0_2 A_1_1 A_1_2 A_2_2)
                        (R.Sem t2 s_0 s_1 B_0_0 B_0_1 B_0_2 B_1_1 B_1_2 B_2_2)
                        (and 
                            (= X_0_0  (and A_0_0 B_0_0))
                            (= X_0_1 (or (and A_0_0 B_0_1) (and A_0_1 B_1_1)))
                            (= X_0_2 (or (and A_0_0 B_0_2) (and A_0_1 B_1_2) (and A_0_2 B_2_2)))
                            (= X_1_1  (and A_1_1 B_1_1))
                            (= X_1_2 (or (and A_1_1 B_1_2) (and A_1_2 B_2_2)))
                            (= X_2_2  (and A_2_2 B_2_2))
                        )
                    )
                )
            )
            (($star t1)
                (exists
                    (
                        (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_2_2 Bool)
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 A_0_0 A_0_1 A_0_2 A_1_1 A_1_2 A_2_2)
                        
                        (and 
                        (= X_0_0 true)
                        (= X_1_1 true)
                        (= X_2_2 true)
                        
                        (= X_0_1 A_0_1)
                        (= X_1_2 A_1_2)
                        
                        (= X_0_2 (or A_0_2 (and A_0_1 A_1_2)))
                        )
                    )
                )
            )
            ; \ 01 , 02 01.12 , 03 01.12.23 01.13 02.23
            ; \ 12 , 13 12.23 
            ; \ 23 ,
            ; \
        )) :input (s_0 s_1) :output (X_0_0 X_0_1 X_0_2 X_1_1 X_1_2 X_2_2))
    )
)

(synth-fun match_regex() Start)
(constraint (Start.Sem match_regex 1 1 true))
(constraint (Start.Sem match_regex 1 2 true))
(constraint (Start.Sem match_regex 1 3 false))
(constraint (Start.Sem match_regex 2 2 false))

;; (constraint (Start.Sem match_regex 1 2 true))
;; (constraint (Start.Sem match_regex 1 0 true))
;; (constraint (Start.Sem match_regex 2 1 false))
;; (constraint (Start.Sem match_regex 1 1 false))
;; (constraint (Start.Sem match_regex 2 0 false))

(check-synth)
