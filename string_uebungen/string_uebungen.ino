// L -> LED(RGB1, RGB2) -> L0F0F0F1F1F1F
// D -> DELAY(ms) -> D1000
// C -> Warte auf Catch -> C
// T -> Warte auf Wurf -> T

String testbefehl1 = "CFF000000FF00";
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
};

class Program {
  private:
    int numberCommands = 0;
    String programString;

  public:
    Program(String program) {
      programString = program;
      for (uint8_t i=0; i<programString.length(); i++){
        if (programString[i] == ';'){
          numberCommands++;
        }
      }
      Serial.print("Programm ");
      Serial.println(programString);
      Serial.print("-> ");
      Serial.print(numberCommands);
      Serial.println(" commands");
    }

};

Command currendCommand("D1000;");
Command currendProgram(testprogramm);

void setup() {
    Serial.begin(115200);
    Serial.println(testprogramm);
    currendCommand = Command("D1000");
}

void loop() {
  currendProgram = new Program(testprogramm);
  currendCommand.print();
  currendCommand = testbefehl1;
  currendCommand.print();
  currendCommand = testbefehl2;
  currendCommand.print();
  delay(1000);

}
