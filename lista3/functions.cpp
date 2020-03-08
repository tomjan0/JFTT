#include<iostream>
#include<cmath>

#include "functions.hpp"

int modulo(int a, int b){
    return a - a/b * b;
} 

int pwr(int a, int b){
    return pow(a, b);
}
