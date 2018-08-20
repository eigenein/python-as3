package game.model.user.mission
{
   import game.data.storage.pve.mission.MissionDescription;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class PlayerMissionBattle
   {
       
      
      private var _desc:MissionDescription;
      
      private var _team:Vector.<PlayerHeroEntry>;
      
      private var sourceObject:Object;
      
      public function PlayerMissionBattle(param1:MissionDescription, param2:Vector.<PlayerHeroEntry>, param3:Object)
      {
         super();
         this.sourceObject = param3;
         this._team = param2;
         _desc = param1;
      }
      
      public function get team() : Vector.<PlayerHeroEntry>
      {
         return _team;
      }
      
      public function get desc() : MissionDescription
      {
         return _desc;
      }
      
      public function get id() : int
      {
         return desc.id;
      }
   }
}
