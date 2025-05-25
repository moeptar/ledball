// L -> LED(RGB1, RGB2) -> L0F0F0F1F1F1F
// D -> DELAY(ms) -> D1000
// C -> Warte auf Catch -> C
// T -> Warte auf Wurf -> T

String testbefehl1 = "LFF000000FF00;";
String testbefehl2 = "D1000;";
String testbefehl3 = "L00FF000000FF;";
String testbefehl4 = "D2000;";
String testbefehl5 = "L0000FFFF0000;";
String testbefehl6 = "D1500;";

String testprogramm = testbefehl1 + testbefehl2 + testbefehl3 + testbefehl4 + testbefehl5 + testbefehl6;

class Command {
  private:
    String type;
    String color0;
    String color1;
    String duration;

  public:
    void setValue(String commandString) {
      type = commandString.substring(0,1);
      if(type == "L"){
        color0 = commandString.substring(1,7);
        color1 = commandString.substring(7,13);
      }
      if(type == "D"){
        duration = commandString.substring(1,commandString.length());
      }
    }

    void print() {
      Serial.print(type + " -> " + color0 + "; " + color1 + "; " + duration);
      Serial.println();
    }

    void execute(){
      if(type == "L") {
        Serial.print("Set LED 1 to (");
        Serial.print(color0.substring(0,2));
        Serial.print(",");
        Serial.print(color0.substring(2,4));
        Serial.print(",");
        Serial.print(color0.substring(4,6));
        Serial.print(")");
        Serial.println();

        Serial.print("Set LED 2 to (");
        Serial.print(color1.substring(0,2));
        Serial.print(",");
        Serial.print(color1.substring(2,4));
        Serial.print(",");
        Serial.print(color1.substring(4,6));
        Serial.print(")");
        Serial.println();
      }
      if(type == "D") {
        Serial.print("Warte ");
        Serial.print(duration);
        Serial.print(" ms");
        Serial.println();

        Serial.print("Waiting");
        delay(atoi(duration.c_str()));
        Serial.println();
      }

    }
};

class Program {
  private:
    int idxProgramString = 0;
    String programString = "LB0B0B0;";

  public:
    void setProgramString(String program) {
      programString = program;
      idxProgramString = 0;
    }

    String nextStep(){
      String restString = programString.substring(idxProgramString);
      Serial.println(restString);
      if(restString.indexOf(';') == -1){
        Serial.println("return to zero");
        idxProgramString = 0;
      } else {
        Serial.println(restString.indexOf(";"));
        idxProgramString = restString.indexOf(";") + 1;
      }
      return restString.substring(idxProgramString, restString.indexOf(";"));
    }
};

Command currendCommand;
Program currendProgram;

void setup() {
    Serial.begin(115200);
    currendCommand.setValue("D1;");
    currendProgram.setProgramString(testprogramm);
}
int idx;
int nextIdx;

void loop() {
//  String command = currendProgram.nextStep();
//  Serial.println("->" + command);
//  currendCommand.setValue(command);
  
  nextIdx = idx + testprogramm.substring(idx).indexOf(";") + 1;
  Serial.println(idx);
  Serial.println(nextIdx);
  Serial.println(testprogramm);
  Serial.println(testprogramm.substring(nextIdx));

  idx = nextIdx;
  if(idx > testprogramm.length()){
    idx = 0;
  }

  delay(1000);
}
