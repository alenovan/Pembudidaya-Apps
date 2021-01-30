import 'dart:convert';

List<ListKolamModelsNew> listKolamModelsNewFromJson(String str) =>
    List<ListKolamModelsNew>.from(
        json.decode(str).map((x) => ListKolamModelsNew.fromJson(x)));

String listKolamModelsNewToJson(List<ListKolamModelsNew> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class ListKolamModelsNew {
  ListKolamModelsNew({
    this.id,
    this.tag,
    this.name,
    this.status,
    this.harvest,
  });

  int id;
  String tag;
  String name;
  int status;
  Harvest harvest;

  factory ListKolamModelsNew.fromJson(Map<String, dynamic> json) => ListKolamModelsNew(
    id: json["id"] == null ? null : json["id"],
    tag: json["tag"] == null ? null : json["tag"],
    name: json["name"] == null ? null : json["name"],
    status: json["status"] == null ? null : json["status"],
    harvest: json["harvest"] == null ? null : Harvest.fromJson(json["harvest"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "tag": tag == null ? null : tag,
    "name": name == null ? null : name,
    "status": status == null ? null : status,
    "harvest": harvest == null ? null : harvest.toJson(),
  };
}

class Harvest {
  Harvest({
    this.id,
    this.pondId,
    this.fishTypeId,
    this.feedId,
    this.lastOrderId,
    this.tag,
    this.sowDate,
    this.seedAmount,
    this.seedWeight,
    this.seedPrice,
    this.survivalRate,
    this.feedConversionRatio,
    this.feedPrice,
    this.targetFishCount,
    this.targetPrice,
    this.currentSr,
    this.currentAmount,
    this.currentWeight,
    this.growthPerDay,
    this.harvestDurationEstimation,
    this.harvestDateEstimation,
    this.harvestWeightEstimation,
    this.feedRequirementEstimation,
    this.currentStockedFeed,
    this.stockRunOutEstimation,
    this.profitEstimation,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.budget,
    this.revenue,
  });

  int id;
  int pondId;
  int fishTypeId;
  int feedId;
  int lastOrderId;
  String tag;
  DateTime sowDate;
  int seedAmount;
  int seedWeight;
  int seedPrice;
  int survivalRate;
  int feedConversionRatio;
  int feedPrice;
  int targetFishCount;
  int targetPrice;
  int currentSr;
  int currentAmount;
  int currentWeight;
  double growthPerDay;
  int harvestDurationEstimation;
  DateTime harvestDateEstimation;
  String harvestWeightEstimation;
  String feedRequirementEstimation;
  String currentStockedFeed;
  DateTime stockRunOutEstimation;
  int profitEstimation;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int budget;
  int revenue;

  factory Harvest.fromJson(Map<String, dynamic> json) => Harvest(
    id: json["id"] == null ? null : json["id"],
    pondId: json["pond_id"] == null ? null : json["pond_id"],
    fishTypeId: json["fish_type_id"] == null ? null : json["fish_type_id"],
    feedId: json["feed_id"] == null ? null : json["feed_id"],
    lastOrderId: json["last_order_id"] == null ? null : json["last_order_id"],
    tag: json["tag"] == null ? null : json["tag"],
    sowDate: json["sow_date"] == null ? null : DateTime.parse(json["sow_date"]),
    seedAmount: json["seed_amount"] == null ? null : json["seed_amount"],
    seedWeight: json["seed_weight"] == null ? null : json["seed_weight"],
    seedPrice: json["seed_price"] == null ? null : json["seed_price"],
    survivalRate: json["survival_rate"] == null ? null : json["survival_rate"],
    feedConversionRatio: json["feed_conversion_ratio"] == null ? null : json["feed_conversion_ratio"],
    feedPrice: json["feed_price"] == null ? null : json["feed_price"],
    targetFishCount: json["target_fish_count"] == null ? null : json["target_fish_count"],
    targetPrice: json["target_price"] == null ? null : json["target_price"],
    currentSr: json["current_sr"] == null ? null : json["current_sr"],
    currentAmount: json["current_amount"] == null ? null : json["current_amount"],
    currentWeight: json["current_weight"] == null ? null : json["current_weight"],
    growthPerDay: json["growth_per_day"] == null ? null : json["growth_per_day"].toDouble(),
    harvestDurationEstimation: json["harvest_duration_estimation"] == null ? null : json["harvest_duration_estimation"],
    harvestDateEstimation: json["harvest_date_estimation"] == null ? null : DateTime.parse(json["harvest_date_estimation"]),
    harvestWeightEstimation: json["harvest_weight_estimation"].toString() == null ? null : json["harvest_weight_estimation"].toString(),
    feedRequirementEstimation: json["feed_requirement_estimation"].toString() == null ? null : json["feed_requirement_estimation"].toString(),
    currentStockedFeed: json["current_stocked_feed"].toString() == null ? null : json["current_stocked_feed"].toString(),
    stockRunOutEstimation: json["stock_run_out_estimation"] == null ? null : DateTime.parse(json["stock_run_out_estimation"]),
    profitEstimation: json["profit_estimation"] == null ? null : json["profit_estimation"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    budget: json["budget"] == null ? null : json["budget"],
    revenue: json["revenue"] == null ? null : json["revenue"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "pond_id": pondId == null ? null : pondId,
    "fish_type_id": fishTypeId == null ? null : fishTypeId,
    "feed_id": feedId == null ? null : feedId,
    "last_order_id": lastOrderId == null ? null : lastOrderId,
    "tag": tag == null ? null : tag,
    "sow_date": sowDate == null ? null : sowDate.toIso8601String(),
    "seed_amount": seedAmount == null ? null : seedAmount,
    "seed_weight": seedWeight == null ? null : seedWeight,
    "seed_price": seedPrice == null ? null : seedPrice,
    "survival_rate": survivalRate == null ? null : survivalRate,
    "feed_conversion_ratio": feedConversionRatio == null ? null : feedConversionRatio,
    "feed_price": feedPrice == null ? null : feedPrice,
    "target_fish_count": targetFishCount == null ? null : targetFishCount,
    "target_price": targetPrice == null ? null : targetPrice,
    "current_sr": currentSr == null ? null : currentSr,
    "current_amount": currentAmount == null ? null : currentAmount,
    "current_weight": currentWeight == null ? null : currentWeight,
    "growth_per_day": growthPerDay == null ? null : growthPerDay,
    "harvest_duration_estimation": harvestDurationEstimation == null ? null : harvestDurationEstimation,
    "harvest_date_estimation": harvestDateEstimation == null ? null : harvestDateEstimation.toIso8601String(),
    "harvest_weight_estimation": harvestWeightEstimation == null ? null : harvestWeightEstimation,
    "feed_requirement_estimation": feedRequirementEstimation == null ? null : feedRequirementEstimation,
    "current_stocked_feed": currentStockedFeed == null ? null : currentStockedFeed,
    "stock_run_out_estimation": stockRunOutEstimation == null ? null : stockRunOutEstimation.toIso8601String(),
    "profit_estimation": profitEstimation == null ? null : profitEstimation,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "budget": budget == null ? null : budget,
    "revenue": revenue == null ? null : revenue,
  };
}