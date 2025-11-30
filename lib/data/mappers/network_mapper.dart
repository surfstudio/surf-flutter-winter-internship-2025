abstract class NetworkMapper<Dto, Entity> {
  Entity toEntity(Dto dto);
  List<Entity> toEntityList(List<Dto> dtos);
}