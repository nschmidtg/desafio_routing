# README

* Ruby version: 2.3.7

* Instalación y carga de base de datos de prueba:
```shell
bundle install
rake db:setup
```

El proyecto se levanta en el puerto 3000 y para el cálculo basta visitar la raíz del proyecto: localhost:3000

Modificaciones a la base de datos original:
* La notación driver_id y vehicle_id me pareció un poco confusa, considerando que para vehículos sin dueño, driver puede tomar un valor distinto de nil y se quiere guardar la relación. Se estableció una modelación en la que se agregó la relación owner y owned para determinar vehículos de dueños. Para obtener el vehículo de un dueño driver: driver.owned. Con esto, la relación driver y vehicle queda liberada para realizar las asignaciones. De esta forma, vehicle y driver tienen dos relaciones (driver-vehicle) y (owned-owner).
* Se agregó un costo por conductor.
* Se agregó un costo por uso del vehículo, que varía dependiendo de las comunas visitadas.
* Se agregó un costo de demanda insatisfecha de la ruta.
* Se agregó un costo de almacenamiento de la ruta, que depende de la load_sum.
* Se separó el load_type para que fuera un modelo aparte y optimizar las búsquedas.

![Imagen del modelo de datos](https://github.com/nschmidtg/desafio_routing/blob/master/erd.pdf)

Consideraciones:
* Dado que el enunciado no hacia alusión a la función objetivo a optimizar, me puse en el lugar de un cliente. Lo más probable es que quisiera optimizar este servicio no para que sea más fácil de asignar, sino también para ahorrarse costos. Me pregunté cuáles podrían ser esos posibles costos y asumí que pueden existir costos para el cliente por demanda insatisfecha, es decir, rutas no asignadas en caso de no satisfacer la demanda, además esta mercancía debe ser almacenada en alguna parte, lo que aumenta los costos del cliente y el supuesto fue hacer un costo por unidad de load.
* Como el problema no estaba claro cuál era la función objetivo a maximizar o minimizar, asumí lo que podría haber sido más deseable por el cliente. Podría haber tratado de maximizar rutas asignadas, pero tampoco sabemos si hay rutas que contienen productos más importantes que otros. El hecho de que el enunciado diferenciara de tipo de carga y camión (refrigerada o general) probablemente no solamente implica una restricción de asignación, sino que además costos diferentes si es general o refrigerada, por eso decidií agregar costos tanto a las rutas no asignadas, como a su almacenamiento, costo por operario de vehículo y costo de uso por vehículo.
* El algoritmo claramente no es óptimo, ya que exísten múltiples métodos para resolver un problema así, muchos tienen el riesgo de encontrar mínimos locales y no globales. Es por esto que decidí un aproach más cercano a una búsqueda. En este sentido, se visualiza la potencial solución como el listao de rutas óptimas asignadas. Cómo el objetivo de esta función no es maximizar las rutas asignadas, sino disminución de costos, existe la posibilidad de que la solución óptima sea incluso no asignar ninguna ruta, debido a que por ejemplo, el costo de uso de camiones sea mayor al de quedar se con la mercancía, almacenándola y pagando el costo de demanda insatisfecha.
* El aproach es por lo tanto: Se genera una matriz donde cada fila es una ruta del día que se está visualizando (se puede modifcar en app/controllers/static_controller.rb:18). Para cada ruta, se tira un número al azar para ver si esa ruta será o no asignada. Si no es asignada, se calcula el costo de no asignarla y se pasa a la siguiente ruta. Si es asignada, se elige aleatoriamente un conductor y vehículo, dentro del universo posible, y se chequean las restricciones. Si no se cumplen todas las restricciones para esta terna (ruta-vehículo-conductor), se corta el ciclo y se comienza nuevamente.
Si al finalizar todas las rutas se tienen asignaciones y no-asignaciones donde todas cumplan todas las restricciones, se tiene una matriz de N+1x4, donde en las columnas se tiene el id de vehículo, conductor, ruta y costo. Si la ruta no fue asignada, conductor y vehículo están en cero. La fila N+1 guarda en su primera posición el costo total de esta configuración.
* Se estableció un tiempo de búsqueda de 10 segundos, el cual puede ser modificado (se recomiendan valores menores a 30 segundos para evitar timeout de Heroku). Durante este tiempo se realizarán ciclos donde se prueban soluciones factibles. Al terminar los 25 segundos se tiene un arreglo de matrices, el cual se recorre para encontrar la matriz calculada con el costo mínimo. Esta es la que finalmente se visualiza.
* Para aumentar o disminuir los tiempos de búsqueda se debe modificar la línea app/controllers/static_controller.rb:28


Formato de base de datos de prueba:
* db/communes.csv: Contiene todas las comunas de la región metropolitana
* vehicles.csv: Contiene los vehículos y sus parámetros
* routes.csv: Contiene las rutas y sus parámetros. Las comunas se cargan mediante el código de la comuna separado por un "/"
* drivers.csv: Contiene los conductores y sus parámetros. Las comunas se cargan mediante el código de la comuna separado por un "/"
