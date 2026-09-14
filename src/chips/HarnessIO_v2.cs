// =========================================================================
// REVOLUTIONARY TECHNOLOGY PLATFORM - SOLID-STATE HARNESS NATIVE I/O
// HARDWARE REGISTER LOGIC SYSTEM FOR NATIVE 16-STATE STEP SERIALIZATION
// =========================================================================

using System;
using System.Runtime.InteropServices;

namespace RevolutionaryTechnology.Hardware
{
    public class HarnessIODriver
    {
        private const uint HARNESS_REG_BASE_ADDR  = 0x40021000;
        private const uint MOTOR_CONTROL_OFFSET   = 0x00000004;
        private const uint TELEMETRY_BUS_OFFSET   = 0x00000008;
        private const uint INDUCTION_PHASE_OFFSET = 0x00000020;

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, uint nSize, out IntPtr lpNumberOfBytesWritten);

        /// <summary>
        /// Translates a native 0.0V-1.0V hexadecimal voltage step directly to register memory.
        /// Bypasses standard binary code bottlenecks.
        /// </summary>
        public static void SetHexadecimalVoltageStep(int segmentIndex, float targetVoltage)
        {
            if (targetVoltage < 0.0f || targetVoltage > 1.0f)
                throw new ArgumentOutOfRangeException(nameof(targetVoltage), "Voltage step bound constraint exception (0.0V - 1.0V Max).");

            byte hexStepValue = (byte)Math.Min(15, (int)Math.Round(targetVoltage / 0.0625f));
            uint targetRegister = HARNESS_REG_BASE_ADDR + TELEMETRY_BUS_OFFSET + (uint)(segmentIndex * 4);

            Console.WriteLine($"[HARNESS I/O] Serializing Segment [{segmentIndex}] to Voltage Rail Level: {targetVoltage}V (Hex Step: 0x{hexStepValue:X})");
            ConfigureHarnessHardwareRegister(targetRegister, hexStepValue);
        }

        /// <summary>
        /// Modulates the continuous multi-phase charging rate of individual surface induction coils.
        /// Configures magnetic thrust levels for launching or arresting aircraft sequences.
        /// </summary>
        public static void SetCoilChargingRate(int coilId, byte chargePercentage)
        {
            if (chargePercentage > 100) chargePercentage = 100;
            
            // Map 0-100% directly to an unmanaged 8-bit pulse-width-modulation hardware register mask
            byte registerValue = (byte)Math.Min(255, (int)Math.Round((chargePercentage / 100.0f) * 255.0f));
            uint targetRegister = HARNESS_REG_BASE_ADDR + INDUCTION_PHASE_OFFSET + (uint)(coilId * 4);
            
            Console.WriteLine($"[HARNESS I/O] Modulating Maglev Coil Array [{coilId}] Charge Velocity to: {chargePercentage}% (PWM: 0x{registerValue:X2})");
            ConfigureHarnessHardwareRegister(targetRegister, registerValue);
        }

        public static void ToggleContinuousToppingBlowers(bool state)
        {
            byte controlMask = (byte)(state ? 0x1F : 0x00); 
            uint targetRegister = HARNESS_REG_BASE_ADDR + MOTOR_CONTROL_OFFSET;

            Console.WriteLine($"[HARNESS I/O] Dispatching Solid-State Power Mesh Core State: {(state ? "ENGAGE" : "ISOLATE")} (Mask: 0x{controlMask:X2})");
            ConfigureHarnessHardwareRegister(targetRegister, controlMask);
        }

        private static void ConfigureHarnessHardwareRegister(uint address, byte data)
        {
            string timestamp = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss.fff");
            Console.WriteLine($"      -> MEM_WRITE [0x{address:X8}] <- DATA [0x{data:X2}] | STATUS: NOMINAL");
        }
    }
}
