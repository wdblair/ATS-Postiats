extern void setup();
extern void event();

int main () {
  setup();
  
  while(1) {
    event();
  }
}
