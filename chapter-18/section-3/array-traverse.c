#include <assert.h>

#define ROW_COUNT               1024
#define COL_COUNT               1024


int global_buffer[ROW_COUNT][COL_COUNT];

void
row_first_write(int value)
{
    int r, c;

    for (c = 0; c < COL_COUNT; c++) {
        for (r = 0; r < ROW_COUNT; r++) {
            global_buffer[r][c] = value;
        }
    }
}

void
row_first_read(int value)
{
    int r, c;

    for (c = 0; c < COL_COUNT; c++) {
        for (r = 0; r < ROW_COUNT; r++) {
            assert (value == global_buffer[r][c]);
        }
    }
}

void
col_first_write(int value)
{
    int r, c;

    for (r = 0; r < ROW_COUNT; r++) {
        for (c = 0; c < COL_COUNT; c++) {
            global_buffer[r][c] = value;
        }
    }
}

void
col_first_read(int value)
{
    int r, c;

    for (r = 0; r < ROW_COUNT; r++) {
        for (c = 0; c < COL_COUNT; c++) {
            assert (value == global_buffer[r][c]);
        }
    }
}

int main(int argc, char *argv[]) {
    int loops = 1000;
    while (loops-- > 0) {
        row_first_write(loops);
        row_first_read(loops);
        col_first_write(loops);
        col_first_read(loops);
    }
    return 0;
}
