package game.view.gui.tutorial
{
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.SkillTier;
   import game.data.storage.skills.SkillDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroSkill;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   
   public class TutorialTaskFinder
   {
       
      
      private var player:Player;
      
      public function TutorialTaskFinder(param1:Player)
      {
         super();
         this.player = param1;
      }
      
      public function heroToUpgradeSkill(param1:TutorialTask) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:PlayerHeroEntry = player.heroes.getById(param1.target.unit.id);
         if(_loc3_)
         {
            _loc2_ = findSkillToUpgrade(_loc3_,param1.target.skill);
            if(_loc2_)
            {
               param1.target.skill = _loc2_;
               param1.completeCondition.data = _loc2_;
               return true;
            }
         }
         Tutorial.__print("heroToUpgradeSkill notFoundPredicted");
         var _loc4_:Vector.<PlayerHeroEntry> = player.heroes.getFilteredList(filter_canUpgradeSkills);
         if(!_loc4_ || _loc4_.length == 0)
         {
            Tutorial.__print("heroToUpgradeSkill notFoundAtAll");
            return false;
         }
         param1.target.unit = _loc4_[0].hero;
         _loc2_ = findSkillToUpgrade(_loc4_[0],null);
         param1.target.skill = _loc2_;
         param1.completeCondition.data = _loc2_;
         return true;
      }
      
      public function heroToPromote(param1:TutorialTask) : Boolean
      {
         return findHeroFor(param1,filter_canPromote,"heroToPromote");
      }
      
      public function heroToEvolve(param1:TutorialTask) : Boolean
      {
         return findHeroFor(param1,filter_canEvolve,"heroToEvolve");
      }
      
      public function heroToEvolveStrict(param1:TutorialTask) : Boolean
      {
         var _loc2_:PlayerHeroEntry = player.heroes.getById(param1.target.unit.id);
         return _loc2_ && filter_canEvolve(_loc2_);
      }
      
      public function heroToEquip(param1:TutorialTask) : Boolean
      {
         return findHeroFor(param1,filter_canEquip,"heroToEquip");
      }
      
      public function titanForArtifactWeaponLevelUp(param1:TutorialTask) : Boolean
      {
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:Vector.<PlayerTitanEntry> = player.titans.getList();
         var _loc5_:int = _loc3_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = _loc3_[_loc6_].artifacts.list;
            _loc9_ = _loc7_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc9_)
            {
               _loc2_ = _loc7_[_loc8_];
               if(_loc2_.desc.artifactType == "weapon" && _loc2_.stars > 0 && _loc2_.nextLevelData)
               {
                  _loc4_ = _loc7_[_loc8_].nextLevelData.cost;
                  if(player.unsafeCanSpendFast(_loc4_))
                  {
                     param1.target.unit = _loc3_[_loc6_].titan;
                     param1.completeCondition.data = _loc2_;
                     return true;
                  }
               }
               _loc8_++;
            }
            _loc6_++;
         }
         return false;
      }
      
      public function titanForArtifactWeaponEvolve(param1:TutorialTask) : Boolean
      {
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:Vector.<PlayerTitanEntry> = player.titans.getList();
         var _loc5_:int = _loc3_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = _loc3_[_loc6_].artifacts.list;
            _loc9_ = _loc7_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc9_)
            {
               _loc2_ = _loc7_[_loc8_];
               if(_loc2_.desc.artifactType == "weapon" && _loc2_.nextEvolutionStar)
               {
                  _loc4_ = _loc7_[_loc8_].nextEvolutionStar.costBase.clone() as CostData;
                  _loc4_.addFragmentItem(_loc2_.desc,_loc2_.nextEvolutionStar.costFragmentsAmount);
                  if(player.unsafeCanSpendFast(_loc4_))
                  {
                     param1.target.unit = _loc3_[_loc6_].titan;
                     param1.completeCondition.data = _loc2_;
                     return true;
                  }
               }
               _loc8_++;
            }
            _loc6_++;
         }
         return false;
      }
      
      protected function findHeroFor(param1:TutorialTask, param2:Function, param3:String) : Boolean
      {
         var _loc4_:PlayerHeroEntry = player.heroes.getById(param1.target.unit.id);
         if(_loc4_ && param2(_loc4_))
         {
            return true;
         }
         Tutorial.__print(param3 + " notFoundPredicted");
         var _loc5_:Vector.<PlayerHeroEntry> = player.heroes.getFilteredList(param2);
         if(!_loc5_ || _loc5_.length == 0)
         {
            Tutorial.__print(param3 + " notFoundAtAll");
            return false;
         }
         _loc4_ = _loc5_[0];
         param1.target.unit = _loc4_.hero;
         param1.completeCondition.data = _loc4_.hero;
         return true;
      }
      
      private function filter_canUpgradeSkills(param1:PlayerHeroEntry) : Boolean
      {
         return player.heroes.watcher.getUpdatedHeroWatch(param1.hero).skillUpgradeAvailable;
      }
      
      private function filter_canPromote(param1:PlayerHeroEntry) : Boolean
      {
         return player.heroes.watcher.getUpdatedHeroWatch(param1.hero).promotable;
      }
      
      private function filter_canEquip(param1:PlayerHeroEntry) : Boolean
      {
         return player.heroes.watcher.getUpdatedHeroWatch(param1.hero).inventorySlotEquipAvailable;
      }
      
      private function filter_canEvolve(param1:PlayerHeroEntry) : Boolean
      {
         var _loc4_:* = null;
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = player.heroes.watcher.getUpdatedHeroWatch(param1.hero).evolvable;
         if(!_loc2_)
         {
            return false;
         }
         if(param1.star.next)
         {
            _loc4_ = param1.star.next.star.evolveGoldCost.clone() as CostData;
            _loc3_ = player.canSpend(_loc4_);
         }
         return _loc3_;
      }
      
      private function findSkillToUpgrade(param1:PlayerHeroEntry, param2:SkillDescription) : SkillDescription
      {
         var _loc5_:int = 0;
         if(param2 && canUpgradeSkill(param1,param2))
         {
            return param2;
         }
         var _loc3_:Vector.<PlayerHeroSkill> = param1.skillData.getSkillList();
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(canUpgradeSkill(param1,_loc3_[_loc5_].skill))
            {
               return _loc3_[_loc5_].skill;
            }
            _loc5_++;
         }
         return null;
      }
      
      private function canUpgradeSkill(param1:PlayerHeroEntry, param2:SkillDescription) : Boolean
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1.canUpgradeSkill(param2))
         {
            _loc4_ = DataStorage.enum.getbyId_SkillTier(param2.tier);
            _loc3_ = DataStorage.level.getSkillLevelCost(param1.skillData.getLevelByTier(_loc4_.id).level,_loc4_.id);
            if(player.canSpend(_loc3_))
            {
               return true;
            }
         }
         return false;
      }
   }
}
