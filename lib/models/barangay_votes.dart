class BarangayVotes {
  final int id;
  final String candidate;
  final int banaban;
  final int baybay;
  final int binagbag;
  final int encanto;
  final int laog;
  final int marungko;
  final int niugan;
  final int paltok;
  final int pulongYantok;
  final int sanRoque;
  final int staCruz;
  final int staLucia;
  final int stoCristo;
  final int sulucan;
  final int taboc;
  final int donacion;

  BarangayVotes({
    required this.id,
    required this.candidate,
    required this.banaban,
    required this.baybay,
    required this.binagbag,
    required this.encanto,
    required this.laog,
    required this.marungko,
    required this.niugan,
    required this.paltok,
    required this.pulongYantok,
    required this.sanRoque,
    required this.staCruz,
    required this.staLucia,
    required this.stoCristo,
    required this.sulucan,
    required this.taboc,
    required this.donacion,
  });

  factory BarangayVotes.fromJson(Map<String, dynamic> json) {
    return BarangayVotes(
      id: json['id'] as int,
      candidate: json['candidate'] as String,
      banaban: json['Banaban'] as int,
      baybay: json['Baybay'] as int,
      binagbag: json['Binagbag'] as int,
      encanto: json['Encanto'] as int,
      laog: json['Laog'] as int,
      marungko: json['Marungko'] as int,
      niugan: json['Niugan'] as int,
      paltok: json['Paltok'] as int,
      pulongYantok: json['Pulong Yantok'] as int,
      sanRoque: json['San Roque'] as int,
      staCruz: json['Sta. Cruz'] as int,
      staLucia: json['Sta. Lucia'] as int,
      stoCristo: json['Sto. Cristo'] as int,
      sulucan: json['Sulucan'] as int,
      taboc: json['Taboc'] as int,
      donacion: json['Donacion'] as int,
    );
  }

  int get votes =>
      banaban +
      baybay +
      binagbag +
      encanto +
      laog +
      marungko +
      niugan +
      paltok +
      pulongYantok +
      sanRoque +
      staCruz +
      staLucia +
      stoCristo +
      sulucan +
      taboc +
      donacion;
}
