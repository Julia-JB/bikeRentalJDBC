package model;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "bike")
@XmlAccessorType(XmlAccessType.FIELD)
public class Bike {
	@JsonProperty("bikeId")
	@XmlElement(name = "bikeId")
	private int bikeId;

	@JsonProperty("brand")
	@XmlElement(name = "brand")
	private String brand;

	@JsonProperty("properties")
	@XmlElement(name = "properties")
	private String properties;

	@JsonProperty("status")
	@XmlElement(name = "status")
	private String status;
	@JsonProperty("currentStationId")
	@XmlElement(name = "currentStationId")
	private int currentStationId;

	public Bike() {};

	public Bike(String brand, String properties, String status, int currentStation) {
		this.brand = brand;
		this.properties = properties;
		this.status = status;
		this.currentStationId = currentStation;
	}
	public Bike(int bikeId, String brand, String properties, String status, int currentStation) {
		this.bikeId = bikeId;
		this.brand = brand;
		this.properties = properties;
		this.status = status;
		this.currentStationId = currentStation;
	}

	@Override
	public String toString() {
		return String.format("\nEntityLayer.Bike ID: %d" +
						     "\nBrand: %s" +
						     "\nProperties: %s" +
				             "\nStatus: %s" +
				             "\nCurrent entityLayer.Station: %d",
				getBikeId(), getBrand(), getProperties(), getStatus(), getCurrentStationId());
	}
	public int getBikeId() {
		return bikeId;
	}

	public void setBikeId(int bikeId) {
		this.bikeId = bikeId;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getProperties() {
		return properties;
	}

	public void setProperties(String properties) {
		this.properties = properties;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getCurrentStationId() {
		return currentStationId;
	}

	public void setCurrentStationId(int currentStationId) {
		this.currentStationId = currentStationId;
	}
}
