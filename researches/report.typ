#import "@local/typst-packages:0.1.0": *

#show: doc => template(
  doc,
  title: "Cryptographie sur les courbes elliptiques",
  subtitle: "TIPE",
)

#all_num.update(true)
#box_thickness.update(2pt)

#include "chapters/1_courbes_elliptiques.typ"

