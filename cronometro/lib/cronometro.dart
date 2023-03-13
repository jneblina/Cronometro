import 'dart:async';

import 'package:flutter/material.dart';

class Cronometro extends StatefulWidget {
  const Cronometro({super.key});

  @override
  State<Cronometro> createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro> {
  int milisegundos = 0;
  bool estaCorriendo = false;
  late Timer timer;
  List vueltas = [];

  void iniciarCronometro() {
    if (!estaCorriendo) {
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        milisegundos += 10;
        setState(() {});
      });
      estaCorriendo = true;
    }
  }

  void detenerCronometro() {
    timer.cancel();
    estaCorriendo = false;
  }

  // void agregarVueltas() {
  //   String vuelta = formatearTiempo();
  //   setState(() {
  //     vueltas.add(vuelta);
  //   });
  // }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatearTiempo(Duration duracion) {
    String dosValores(int valor) {
      if (valor >= 10) {
        return '$valor';
      } else {
        return '0$valor';
      }
    }

    String horas = dosValores(duracion.inHours);
    String minutos = dosValores(duracion.inMinutes.remainder(60));
    String segundos = dosValores(duracion.inSeconds.remainder(60));
    String milisegundos =
        dosValores(duracion.inMilliseconds.remainder(1000)).substring(0, 2);

    return "$horas:$minutos:$segundos:$milisegundos";
  }

  Duration get tiempo => Duration(milliseconds: milisegundos);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatearTiempo(tiempo),
          style: const TextStyle(fontSize: 50, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: iniciarCronometro,
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 50,
                  color: Colors.green,
                )),
            TextButton(
              onPressed: detenerCronometro,
              child: const Icon(
                Icons.pause_rounded,
                size: 50,
                color: Colors.red,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  milisegundos = 0;
                  vueltas = [];
                  setState(() {});
                },
                child: const Icon(
                  Icons.restart_alt_rounded,
                  color: Colors.amber,
                  size: 50,
                )),
            TextButton(
                onPressed: estaCorriendo
                    ? () {
                        setState(() {
                          vueltas.add(tiempo);
                        });
                      }
                    : null,
                child: const Icon(
                  Icons.flag_rounded,
                  color: Colors.white,
                  size: 50,
                )),
          ],
        ),
        vueltas.isEmpty
            ? Container(
                height: 0,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                ))
            : Container(
                height: 350,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: vueltas.length,
                  itemBuilder: (context, index) {
                    final diff = index == 0
                        ? vueltas[index]
                        : vueltas[index] - vueltas[index - 1];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.flag, color: Colors.white),
                          Text(
                            '#${index + 1}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '+${formatearTiempo(diff)}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            formatearTiempo(vueltas[index]),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
