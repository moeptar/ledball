// L -> LED(RGB1, RGB2) -> L0F0F0F1F1F1F
// D -> DELAY(ms) -> D1000
// C -> Warte auf Catch -> C
// T -> Warte auf Wurf -> T

String testbefehl1 = "LFF000000FF00";
String testbefehl2 = "D000000000500";
String testbefehl3 = "L00FF000000FF";
String testbefehl4 = "D000000001000";
String testbefehl5 = "L0000FFFF0000";
String testbefehl6 = "D000000001500";

String testprogramm = testbefehl1 + ";" + testbefehl2 + ";" + testbefehl3 + ";" + testbefehl4 + ";" + testbefehl5 + ";" + testbefehl6 + ";";

class Command {
  private:
    String type;
    String color0;
    String color1;
    String duration;

  public:
    Command(String commandString) {
      type = commandString.substring(0,1);
      color0 = commandString.substring(1,7);
      color1 = commandString.substring(8,14);
      duration = commandString.substring(1,14);
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
        Serial.print(color0.substring(3,5));
        Serial.print(",");
        Serial.print(color0.substring(4,6));
        Serial.print(")");
        Serial.println();

        Serial.print("Set LED 2 to (");
        Serial.print(color1.substring(0,2));
        Serial.print(",");
        Serial.print(color1.substring(3,5));
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
      }

    }
};

class Program {
  private:
    int numberCommands = 0;
    int idxCommand = 0;
    String programString = "LB0B0B0";

  public:

    void setProgramString(String program) {
      programString = program;
      for (uint8_t i=0; i < programString.length(); i++){
        if (programString[i] == ';'){
          numberCommands++;
        }
      }
      Serial.print("Program ");
      Serial.println(programString);
      Serial.print("-> ");
      Serial.print(numberCommands);
      Serial.println(" commands");    }

};

Command currendCommand("D1000;");
Program currendProgram;

void setup() {
    Serial.begin(115200);
    Serial.println(testprogramm);
    currendCommand = Command("D1000");
    currendProgram.setProgramString(testprogramm);
}

void loop() {
  currendCommand.execute();
  currendCommand = testbefehl1;
  currendCommand.execute();
  currendCommand = testbefehl2;
  currendCommand.execute();
  currendCommand = testbefehl3;
  currendCommand.execute();
  currendCommand = testbefehl4;
  currendCommand.execute();
  delay(1000);

}
