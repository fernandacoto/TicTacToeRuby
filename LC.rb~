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
    #array = [["O"," ","X"],[" ","X"," "],[" "," "," "]]
    #array = [["X"," "," "],[" "," "," "],[" "," "," "]]
    #array = [["X","O","X"],[" ","O"," "],[" "," ","X"]]
    #array = [["X","O","X"],[" ","O"," "],[" ","X"," "]]
    #array = [["X","X"," "],[" ","O"," "],[" "," "," "]]
    array = [[" "," "," "],[" ","X"," "],[" "," "," "]]
    movida_computadora(array,1)
    $movida.each {|x| print"ELEMENTO #{x}\n"}
  end

  def movida_computadora(tablero, cantidad_casillas_ocupadas)
    $fila = 0
    $columna = 0
    $movimientos = cantidad_casillas_ocupadas # cambiar movimientos por casillas_ocupadas
    if $movimientos < 3
      encontrar_fila_vacia(tablero)
    else
      elegir_jugada(tablero)
    end
    return $movida
  end

  def elegir_jugada(tablero)
    encontrar_fila_vacia(tablero)
    if $solucion == true
      return $movida
    else
      verificar_posibilidad_gane_usuario(tablero)
    end
    return $movida
  end

  def verificar_posibilidad_gane_usuario(tablero)
    $simbolo = "X"
    $solucion = false
    $solucion = buscar_opciones_gane_usuario(tablero)
    if $solucion == true
      return $movida
    else
      chequear_movimiento_acertado(tablero)
    end
  end

  def chequear_movimiento_acertado(tablero)
    if $solucion == false
      $fila = 0
      $columna = 0
      $simbolo = " "
      $simbolo_encontrado = false
      primer_movimiento(tablero)
    end

  end

  def buscar_opciones_gane_usuario(tablero)
    iteraciones = repetir_busqueda_solucion
    iteraciones.times do
      encontrar_fila(tablero)
      revisar_tablero_usuario(tablero)
    end
    return $solucion
  end

  def repetir_busqueda_solucion
    cantidad_casillas_ocupadas = $movimientos % 2
    if cantidad_casillas_ocupadas.even?
      return cantidad_casillas_ocupadas
    else
      return (($movimientos - 1) / 2) + 1
    end
  end

  def revisar_tablero_usuario(tablero)
    revisar_filas(tablero)
    revisar_columnas(tablero)
    revisar_diagonales(tablero)
  end

  def revisar_diagonales(tablero)
    if $solucion == false && tablero[1][1] == $simbolo
      $fila = 1
      $columna = 1
      comparacion(tablero,$fila - 1,$columna - 1,$fila + 1,$columna + 1)
      comparacion(tablero,$fila - 1,$columna + 1,$fila + 1,$columna - 1)
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
    while $simbolo_encontrado == false && $fila < 3
      buscar_columna_vacia(arreglo)
      if $simbolo_encontrado == false
        $fila += 1
        $columna = 0
      end
    end
  end

  def buscar_columna_vacia(arreglo)
     $simbolo = " "
     while $simbolo_encontrado == false && $columna < 3
       if arreglo[$fila][$columna] == $simbolo
         $movida[0] = $fila
         $movida[1] = $columna
         $simbolo_encontrado = true
       else
         $columna += 1
       end
     end
  end

  def proximo_movimiento(arreglo)
    $simbolo = "O"
    $iteraciones_de_busqueda = $movimientos / 2
    $iteraciones_de_busqueda.times do
      encontrar_fila(arreglo)
      posibilidad_de_ganar(arreglo)
    end
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

  def revisar_filas_vacias(arreglo)
    #$simbolo= " "
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
        $movida[0]=fila1
        $movida[1]=columna1
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
    if $solucion == false && fila1 < 3 && fila2 < 3
      if arreglo[fila1][columna1] == $simbolo && arreglo[fila2][columna2] == " "
        $solucion = true
        $movida[0]=fila2
        $movida[1]=columna2
      else 
        if arreglo[fila1][columna1] == " " && arreglo[fila2][columna2] == $simbolo
        $solucion = true
        $movida[0]=fila1
        $movida[1]=columna1
        else 
          $solucion = false
        end
      end
    end
    return $solucion
  end
end
#pru = Logica_Computadora.new()
#pru.prueba
