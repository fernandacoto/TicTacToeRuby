class Logica_Computadora
  $solucion
  $simbolo
  $simbolo_encontrado
  $fila
  $columna
  $movimientos
  $movida
  $iteraciones_de_busqueda

  def initialize
    $fila = 0
    $columna = 0
    $simbolo = "O"
    $movida = []
  end

  def prueba
    array = [["O","X","X"],["O","X"," "],[" "," "," "]]
    movida_computadora(array,5)
    $movida.each {|x| print"ELEMENTO #{x}\n"}
  end

  def movida_computadora(arreglo, movimientos)
    $fila = 0
    $columna = 0
    $movimientos = movimientos
    verificar_posibilidad_gane_usuario(tablero)
    return $movida
  end

  def verificar_posibilidad_gane_usuario(tablero)
    $simbolo = "O"
    $solucion = buscar_opciones_gane_usuario(tablero) # falta implementar
    if $solucion
      return $movida
    else
      encontrar_fila_vacia(arreglo)
    end
  end

  def encontrar_fila_vacia(arreglo)
    $simbolo_encontrado = false
    if $movimientos < 2
      primer_movimiento(arreglo)
    else
      proximo_movimiento(arreglo)
    end
  end

  def primer_movimiento(arreglo)
    if arreglo[1][1] == " "
      2.times do $movida.push(1) end
    else
      buscar_movida(arreglo)
    end
  end

  def buscar_movida(arreglo)
    while $simbolo_enocntrado == false && fila < 3
      buscar_columna_vacia(arreglo)
      if $simbolo_encontrado == false
        $fila += 1
        $columna = 0
      end
    end
  end

  def buscar_columna_vacia(arreglo)
     while $simbolo_encontrado == false && $columna < 3
       if arreglo[$fila][$columna] == $simbolo
         $movida.push($fila)
         $movida.push($columna)
         $simbolo_encontrado = true
       else
         $columna += 1
       end
     end
  end

  def proximo_movimiento(arreglo)
    $iteraciones_de_busqueda = $movimientos / 2
    $iteraciones_de_busqueda.times {encontrar_fila(arreglo)}
  end

  def encontrar_fila(arreglo)
    $simbolo_encontrado = false
    while $simbolo_encontrado == false && $fila < 3
      encontrar_columna(arreglo)
      if $simbolo_encontrado == false
        $fila += 1
        $columna = 0
      end
    end
    posible_jugada(arreglo)
  end

  def encontrar_columna(arreglo)
    while $simbolo_encontrado == false && $columna < 3
      if arreglo[$fila][$columna] == $simbolo
        $simbolo_encontrado = true
      else
        $columna += 1
      end
    end
  end

  def posible_jugada(arreglo)
    if (($iteraciones_de_busqueda * 2) + 1) == 3
      segundo_movimiento(arreglo)
    else
      posibilidad_de_ganar(arreglo)
    end
  end

  def segundo_movimiento(arreglo)
    $solucion = false
    revisar_filas_vacias(arreglo)
    revisar_columnas_vacias(arreglo)
    if $solucion == false && arreglo[1][1] = $simbolo
      $fila = 1
      $columna = 1
      eleccion(arreglo,$fila - 1,$columna - 1,$fila + 1,$columna + 1)
      eleccion(arreglo,$fila - 1,$columna + 1,$fila + 1,$columna - 1)
    end
  end

  def revisar_filas_vacias(arreglo)
    if $fila == 0
      eleccion(arreglo,$fila + 1, $columna, $fila + 2, $columna)
    end
    if $fila == 1
      eleccion(arreglo,$fila + 1, $columna, $fila - 1, $columna)
    end
    if $fila == 2
      eleccion(arreglo,$fila - 1, $columna, $fila - 2, $columna)
    end
  end

  def revisar_columnas_vacias(arreglo)
    if $columna == 0
      eleccion(arreglo,$fila,$columna + 1, $fila,$columna + 2)
    end
    if $columna == 1
      eleccion(arreglo,$fila,$columna + 1, $fila,$columna - 1)
    end
    if $columna == 2
      eleccion(arreglo,$fila,$columna - 1, $fila,$columna - 2)
    end
  end

  def eleccion(arreglo,fila1,columna1,fila2,columna2)
    if $solucion == false
      if arreglo[fila1][columna1] == " " && arreglo[fila2][columna2] == " "
        $solucion = true
        $movida.push(fila1)
        $movida.push(columna1)
      end
    end
  end

  def posibilidad_de_ganar(arreglo)
    $solucion = false
    revisar_filas(arreglo)
    revisar_columnas(arreglo)
    if $solucion == false && arreglo[1][1] == $simbolo
      $fila = 1
      $columna = 1
      comparacion(arreglo,$fila - 1,$columna - 1,$fila + 1,$columna + 1)
      comparacion(arreglo,$fila - 1,$columna + 1,$fila + 1,$columna - 1)
    end
  end

  def revisar_filas(arreglo)
    if $fila == 0
      comparacion(arreglo,$fila + 1, $columna, $fila + 2, $columna)
    end
    if $fila == 1
      comparacion(arreglo,$fila + 1, $columna, $fila - 1, $columna)
    end
    if $fila == 2
      comparacion(arreglo,$fila - 1, $columna, $fila - 2, $columna)
    end
  end

  def revisar_columnas(arreglo)
    if $columna == 0
      comparacion(arreglo,$fila,$columna + 1, $fila,$columna + 2)
    end
    if $columna == 1
      comparacion(arreglo,$fila,$columna + 1, $fila,$columna - 1)
    end
    if $columna == 2
      comparacion(arreglo,$fila,$columna - 1, $fila,$columna - 2)
    end
  end

  def comparacion(arreglo,fila1,columna1,fila2,columna2)
    if $solucion == false
      if arreglo[fila1][columna1] == $simbolo && arreglo[fila2][columna2] == " "
        $solucion = true
        $movida.push(fila2)
        $movida.push(columna2)
      end
      if arreglo[fila1][columna1] == " " && arreglo[fila2][columna2] == $simbolo
        $solucion = true
        $movida.push(fila1)
        $movida.push(columna1)
      end
    end
  end
end
#pru = Logica_Computadora.new()
#pru.prueba
