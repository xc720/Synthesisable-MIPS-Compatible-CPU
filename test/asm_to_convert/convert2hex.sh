for f in *.asm; do
    mips-linux-gnu-as -o hex/$f.out $f
    mips-linux-gnu-readelf --hex-dump=.text hex/$f.out | sed -n -e '/0x00000000/,$p' | sed 's/^ *0x//g' | xxd -r | xxd -p -c 10000000000 | sed 's/.\{8\}/& \n/g' > hex/$f.txt
    rm hex/$f.out
done