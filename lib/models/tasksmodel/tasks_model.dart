

 class Tasks{

    String? title;
    String? time;
    DateTime? date;
    Tasks({
      this.title,this.time,this.date
 });
    Tasks.withid({
      this.title,this.time,this.date
    });

    Map<String ,dynamic> toMap(){
      final map=Map<String ,dynamic>();
      map['title']=title;
      map['time']=time;
      map['date']=date!.toIso8601String();
      return map;
    }
    factory Tasks.fromMap(Map<String,dynamic>map){
      return Tasks.withid(
        time: map['time'],
        title: map['title'],
        date: DateTime.parse(map['date']) ,
      );
    }
 }