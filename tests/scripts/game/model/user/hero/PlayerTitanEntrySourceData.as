package game.model.user.hero
{
   import game.data.storage.DataStorage;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.titan.TitanDescription;
   
   public class PlayerTitanEntrySourceData extends TitanEntrySourceData
   {
       
      
      public var artifacts:Array;
      
      public var skills:Object;
      
      private var _xp:int;
      
      public function PlayerTitanEntrySourceData(param1:Object = null)
      {
         super(param1);
         if(param1)
         {
            skills = param1.skills;
            artifacts = param1.artifacts;
         }
      }
      
      public static function createEmpty(param1:TitanDescription) : PlayerTitanEntrySourceData
      {
         var _loc3_:PlayerTitanEntrySourceData = new PlayerTitanEntrySourceData();
         _loc3_.skills = [];
         var _loc2_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(param1.id);
         var _loc4_:int = _loc2_.length;
         _loc3_.star = param1.startingStar.star.id;
         _loc3_.id = param1.id;
         return _loc3_;
      }
      
      override public function set level(param1:int) : void
      {
         _level = param1;
         _xp = DataStorage.level.getHeroLevel(_level).exp;
      }
      
      public function get xp() : int
      {
         return _xp;
      }
      
      public function set xp(param1:int) : void
      {
         _xp = param1;
         _level = DataStorage.level.getHeroLevelByExp(_xp).level;
      }
      
      public function setSkillLevels(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(id);
         var _loc4_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1[_loc2_[_loc3_].id])
            {
               this.skills[_loc2_[_loc3_].id] = param1[_loc2_[_loc3_].id];
            }
            _loc3_++;
         }
      }
      
      override protected function parseLevel(param1:Object) : void
      {
         if(param1.xp)
         {
            xp = param1.xp;
            return;
         }
         if(param1.lvl)
         {
            level = param1.lvl;
         }
         else if(param1.level)
         {
            level = param1.level;
         }
      }
   }
}
