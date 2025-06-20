package digitalnurture.BuilderPatternExample;

public class Computer {

    private final String cpu;
    private final String ram;
    private final String storage;
    private final String bluetooth;
    private final String integratedGraphicsCard;

    // Private constructor: only accessible through the builder
    private Computer(ComputerBuilder builder) {
        this.cpu = builder.cpu;
        this.ram = builder.ram;
        this.storage = builder.storage;
        this.bluetooth = builder.bluetooth;
        this.integratedGraphicsCard = builder.integratedGraphicsCard;
    }

    @Override
    public String toString() {
        return "CPU --> " + cpu +
               " | RAM --> " + ram +
               " | Storage --> " + storage +
               " | Bluetooth --> " + (bluetooth != null ? bluetooth : "disabled") +
               " | Integrated Graphics Card --> " + integratedGraphicsCard;
    }

    // Builder class
    public static class ComputerBuilder {
        private final String cpu;
        private final String ram;
        private final String storage;
        private String bluetooth;
        private String integratedGraphicsCard = "NVIDIA GTX 1650";  // Default value

        public ComputerBuilder(String cpu, String ram, String storage) {
            this.cpu = cpu;
            this.ram = ram;
            this.storage = storage;
        }

        public ComputerBuilder enableBluetooth(String bluetooth) {
            this.bluetooth = bluetooth;
            return this;
        }

        public ComputerBuilder setIntegratedGraphicsCard(String graphicsCard) {
            this.integratedGraphicsCard = graphicsCard;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }
    }

    // Test the builder pattern
    public static void main(String[] args) {
        Computer businessComputer = new Computer.ComputerBuilder("Intel", "8 GB", "256 SSD")
                .enableBluetooth("enabled")
                .build();

        System.out.println(businessComputer);

        Computer gamingComputer = new Computer.ComputerBuilder("NVIDIA", "16 GB", "512 SSD")
                .setIntegratedGraphicsCard("NVIDIA RTX 3060")
                .build();

        System.out.println(gamingComputer);
    }
}