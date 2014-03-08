/*
 *  Copyright 2014 Abid Hasan Mujtaba
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import lejos.hardware.Button;
import lejos.hardware.lcd.LCD;
import lejos.hardware.motor.Motor;
import lejos.robotics.RegulatedMotor;

/**
 * LeJOS project for using a ribbon to raise and lower an object connected to the primary motor.
 */

public class Lift
{
    static RegulatedMotor motor = Motor.A;

    static final int SPEED = 200;


    public static void main(String[] args)
    {
        int button;

        log("Program Starts ...");

        initialize();

        while (true)
        {
            button = Button.waitForAnyPress();

            switch (button)
            {
                case Button.ID_ESCAPE:
                    return;

                case Button.ID_UP:
                    up();
                    break;

                case Button.ID_DOWN:
                    down();
                    break;

                default:
                    stop();
            }
        }
    }


    private static void initialize()
    {
        LCD.clear();

        motor.setSpeed( SPEED );
    }


    private static void stop()
    {
        motor.stop();

        log("STOP");
    }


    private static void up()
    {
        motor.backward();

        log("UP");
    }


    private static void down()
    {
        motor.forward();

        log("DOWN");
    }


    private static void log(String msg)
    {
        System.out.println("log>\t" + msg);
    }
}
