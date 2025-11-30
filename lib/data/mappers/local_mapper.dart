abstract class LocalMapper<StorageModel, Entity> {
  Entity toEntity(StorageModel model);
  List<Entity> toEntityList(List<StorageModel> models);
  StorageModel toStorageModel(Entity entity);
}
