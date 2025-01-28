clear
echo "Output:"
echo

nasm $1.asm -f elf64 -o $1.o
gcc $1.o -z noexecstack
./a.out

exitCode=$?

echo
echo "Exit Code:"
echo $exitCode

rm a.out
rm $1.o
