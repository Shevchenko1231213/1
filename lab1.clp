(deftemplate family
   (slot name (type SYMBOL) (default Unk))
   (slot wife (type SYMBOL) (default Unk))
   (slot son (type SYMBOL) (default Unk))
   (slot Ola (type SYMBOL) (default Unk))
   (slot Gala (type SYMBOL) (default Unk))
   (slot Mela (type SYMBOL) (default Unk))
   (slot Oh (type SYMBOL) (default Unk))
   (slot Ah (type SYMBOL) (default Unk))
   (slot Eh (type SYMBOL) (default Unk))
)

(deffacts data
   (family (name Og) (Mela false) (Ola false) (Gala true) (Eh false) (Ah false) (Oh true))
   (family (name Gog) (Ola false) (Gala false) (Mela true) (Eh false) (Oh false) (Ah true))
   (family (name Magog) (Mela false) (Gala false) (Ola true) (Ah false) (Oh false) (Eh true))
)

(defrule PrintInfo
   (family (name ?name) (wife ?wife) (son ?son))
   ?Og<-(family (name Og) (wife ~Unk) (son ~Unk))
   ?Gog<-(family (name Gog) (wife ~Unk) (son ~Unk))
   ?Magog<-(family (name Magog) (wife ~Unk) (son ~Unk))
   =>
   (printout t crlf ?name"'s data:" crlf
   "Wife is:"?wife crlf
   "Son is:"?son crlf crlf)
)

(defrule IfOgWifeGalaSonOh
    (family (name ?name))
    ?Family<-(family (name Og) (Mela false) (Ola false) (Eh false) (Ah false))
    =>
    (modify ?Family (wife Gala) (son Oh) (Gala true) (Oh true))
)

(defrule IfGogWifeMelaSonAh
    (family (name ?name))
    ?Family<-(family (name Gog) (Gala false) (Ola false) (Oh false) (Eh false))
    =>
    (modify ?Family (wife Mela) (son Ah) (Mela true) (Ah true))
)

(defrule IfMagogWifeOlaSonEh
    (family (name ?name))
    ?Family<-(family (name Magog) (Gala false) (Mela false) (Oh false) (Ah false))
    =>
    (modify ?Family (wife Ola) (son Eh) (Ola true) (Eh true))
)

(defrule IfOgWifeGala
   (family (name ?name))
   ?Family<-(family (name Og) (wife Gala))
   ?Gog<-(family (name Gog))
   ?Magog<-(family (name Magog))
   =>
   (modify ?Gog (Gala false))
   (modify ?Magog (Gala false))
)

(defrule IfGogWifeMela
   (family (name ?name))
   ?Family<-(family (name Gog) (wife Mela))
   ?Og<-(family (name Og))
   ?Magog<-(family (name Magog))
   =>
   (modify ?Og (Mela false))
   (modify ?Magog (Mela false))
)

(defrule IfMagogWifeOla
   (family (name ?name))
   ?Family<-(family (name Magog) (wife Ola))
   ?Og<-(family (name Og))
   ?Gog<-(family (name Gog))
   =>
   (modify ?Og (Ola false))
   (modify ?Gog (Ola false))
)

(defrule IfOgSonOh
   (family (name ?name))
   ?Family<-(family (name Og) (son Oh))
   ?Gog<-(family (name Gog))
   ?Magog<-(family (name Magog))
   =>
   (modify ?Gog (Oh false))
   (modify ?Magog (Oh false))
)

(defrule IfGogSonAh
   (family (name ?name))
   ?Family<-(family (name Gog) (son Ah))
   ?Og<-(family (name Og))
   ?Magog<-(family (name Magog))
   =>
   (modify ?Og (Ah false))
   (modify ?Magog (Ah false))
)

(defrule IfMagogSonEh
   (family (name ?name))
   ?Family<-(family (name Gog) (son Eh))
   ?Og<-(family (name Og))
   ?Gog<-(family (name Gog))
   =>
   (modify ?Og (Eh false))
   (modify ?Gog (Eh false))
)

