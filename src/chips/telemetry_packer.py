#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
RT Silicon Component: High-Density Telemetry Nibble-Packer & Stream Serializer
Compresses 16-State Analog Voltages to Reduce Bus Line Bitrate Over Long Tows
"""

import numpy as np

class TelemetryDataPacker:
    def __init__(self):
        print("[PACKER] Initializing high-density bit-packing compression matrix...")

    def pack_voltage_stream(self, floating_voltages):
        """
        Packs two adjacent 16-state step channels into a single byte stream array.
        Eliminates transmission bottlenecks along trailing cable lines.
        """
        num_elements = len(floating_voltages)
        packed_bytes = []
        
        print(f"[*] Ingesting {num_elements} parallel analog telemetry rail nodes...")
        
        # Step through data pairs sequentially
        for idx in range(0, num_elements, 2):
            # Quantize float voltage values to discrete 4-bit integers (0x0 - 0xF)
            val_high = int(math.round(floating_voltages[idx] / 0.0625)) if idx < num_elements else 0
            val_low  = int(math.round(floating_voltages[idx+1] / 0.0625)) if (idx + 1) < num_elements else 0
            
            # Ensure hard constraints fit within 4-bit nibble properties
            val_high = min(15, max(0, val_high))
            val_low  = min(15, max(0, val_low))
            
            # Compress pairs together via bitwise shifting operations
            compressed_byte = (val_high << 4) | val_low
            packed_bytes.append(compressed_byte)
            
        output_array = np.array(packed_bytes, dtype=np.uint8)
        print(f"  [SUCCESS] Compression complete. Stream size reduced to: {len(output_array)} bytes.")
        print(f"  [+] Compressed Stream Buffer: {[hex(b) for b in output_array]}")
        return output_array

def run_serialization_pass():
    import math
    packer = TelemetryDataPacker()
    # Mock a sequence of fluctuating voltage points tracking plate joint values
    mock_analog_bus = [1.0, 0.9375, 1.0, 0.5, 0.875, 1.0, 1.0, 1.0, 0.0, 0.0625, 1.0, 0.9375]
    packer.pack_voltage_stream(mock_analog_bus)

if __name__ == "__main__":
    import math
    run_serialization_pass()
