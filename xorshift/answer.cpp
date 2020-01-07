#include <stdio.h>

typedef unsigned int xint;

class XorShift {
private:
	xint x;
	xint y;
	xint z;
	xint w;

public:
	XorShift( xint x = 0, xint y = 0, xint z = 0, xint w = 0 ) {
		this->seed( x, y, z, w );
	}

	void seed( xint x = 0, xint y = 0, xint z = 0, xint w = 0 ) {
		if ( !x && !y && !z && !w ) {
			x = 123456789;
			y = 362436069;
			z = 521288629;
			w = 88675123;
		}
		this->x = x;
		this->y = y;
		this->z = z;
		this->w = w;
	}

	xint nextInt() {
		xint t = ( this->x ^ ( this->x << 11 ) );
		this->x = this->y;
		this->y = this->z;
		this->z = this->w;
		this->w = ( this->w ^ ( this->w >> 19 ) ^ ( t ^ ( t >> 8 ) ) );

		return this->w;
	}

	double next() {
		return (double)this->nextInt() / 0xffffffff;
	}
};

int main() {
	XorShift *xos = new XorShift();
	char *format = "0x%04x\n";

	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	/*printf( "----\n" );
	xos->seed();
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( "----\n" );
	xos->seed( 0, 0, 0, 0 );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );
	printf( format, xos->nextInt() );*/
	return 0;
}