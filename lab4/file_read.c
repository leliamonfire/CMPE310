#include <stdio.h>
#include <stdlib.h>

extern int add_numbers(int*);

int main() {

    int data[51];
    FILE *newfile;
    char entered_file[10];
    char buff[256];

    printf("Enter file name: \n");
    scanf("%s", entered_file);

    newfile = fopen(entered_file, "r");


    while(fgets(buff, sizeof(buff), newfile) != NULL) {
        int count = 0;

        data[count] = atoi(buff);
        count++;
        printf("%s", buff);
    }
    printf("%s", buff);

    //for (int i = 0; i < 51; i++) {
    //    printf("%d\n", data[i]);
    //}


    fclose(newfile);
    return 0;
}
