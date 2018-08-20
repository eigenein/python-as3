package game.data.storage.skills
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionStorage;
   
   public class SkillDescriptionStorage extends DescriptionStorage
   {
       
      
      private const byHeroId:Dictionary = new Dictionary();
      
      public function SkillDescriptionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:SkillDescription = new SkillDescription(param1);
         _items[_loc2_.id] = _loc2_;
         if(_loc2_.disabled)
         {
            return;
         }
         var _loc3_:Vector.<SkillDescription> = byHeroId[_loc2_.hero];
         if(_loc3_)
         {
            _loc3_[_loc3_.length] = _loc2_;
         }
         else
         {
            byHeroId[_loc2_.hero] = new <SkillDescription>[_loc2_];
         }
      }
      
      public function getByHero(param1:int) : Vector.<SkillDescription>
      {
         return byHeroId[param1];
      }
      
      public function getByHeroAndTier(param1:int, param2:int) : SkillDescription
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Vector.<SkillDescription> = byHeroId[param1];
         if(_loc4_)
         {
            _loc3_ = _loc4_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               if(_loc4_[_loc5_].tier == param2)
               {
                  return _loc4_[_loc5_];
               }
               _loc5_++;
            }
         }
         return null;
      }
      
      public function getUpgradableSkillsByHero(param1:int) : Vector.<SkillDescription>
      {
         var _loc2_:Vector.<SkillDescription> = byHeroId[param1];
         if(_loc2_)
         {
            _loc2_ = _loc2_.slice(1);
         }
         return _loc2_;
      }
      
      public function getSkillById(param1:uint) : SkillDescription
      {
         return _items[param1];
      }
      
      public function getAutoAttackByHero(param1:int) : SkillDescription
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Vector.<SkillDescription> = byHeroId[param1];
         if(_loc3_)
         {
            _loc5_ = _loc3_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               if(_loc3_[_loc4_].tier == 0)
               {
                  return _loc3_[_loc4_];
               }
               _loc4_++;
            }
            return _loc3_[0];
         }
         return null;
      }
   }
}
