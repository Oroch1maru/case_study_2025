class LibraryRecord:
    def __init__(self, raw:dict):
        self.props = raw.get("properties", {})
        self.geometry = raw.get("geometry", {})
        self.address = self.props.get("address", {})

    def format_opening_hours(self) -> str:
        entries = self.props.get("opening_hours", [])
        result = []
        for entry in entries:
            day = entry.get("day_of_week")
            opens = entry.get("opens")
            closes = entry.get("closes")
            if entry.get("is_default"):
                result.append(f"{day}: {opens} - {closes}")
            else:
                desc = entry.get("description", "")
                result.append(f"{day}: {opens} - {closes} (Description: {desc})")
        return "; ".join(result)

    def to_dict(self) -> dict:
        coords = self.geometry.get("coordinates", [None, None])
        city = self.address.get("address_locality", "").split()[0]

        return {
            "ID knižnice": self.props.get("id"),
            "Názov knižnice": self.props.get("name"),
            "Ulica": self.address.get("street_address"),
            "PSČ": self.address.get("postal_code"),
            "Mesto": city,
            "Kraj": self.address.get("address_region"),
            "Krajina": self.address.get("address_country"),
            "Zemepisná šírka": coords[1],
            "Zemepisná dĺžka": coords[0],
            "Čas otvorenia": self.format_opening_hours()
        }
