package game.model.user.hero.watch
{
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.user.hero.PlayerHeroArtifact;
   
   public class PlayerHeroWatchInventory
   {
       
      
      private var parent:PlayerHeroWatcher;
      
      public function PlayerHeroWatchInventory(param1:PlayerHeroWatcher)
      {
         super();
         this.parent = param1;
      }
      
      public function getHeroListForArtifact(param1:ArtifactDescription) : Vector.<HeroEntryValueObject>
      {
         var _loc2_:* = null;
         var _loc8_:* = undefined;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc5_:Vector.<HeroEntryValueObject> = new Vector.<HeroEntryValueObject>();
         var _loc10_:int = 0;
         var _loc9_:* = parent.dict;
         for(var _loc6_ in parent.dict)
         {
            _loc2_ = parent.dict[_loc6_];
            if(_loc2_.playerEntry)
            {
               _loc8_ = _loc2_.playerEntry.artifacts.list;
               _loc4_ = _loc8_.length;
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc3_ = _loc8_[_loc7_];
                  if(_loc3_.desc == param1)
                  {
                     if(_loc3_.desc.artifactType == "weapon" || _loc3_.nextEvolutionStar)
                     {
                        _loc5_.push(new HeroEntryValueObject(_loc2_.hero,_loc2_.playerEntry));
                     }
                  }
                  _loc7_++;
               }
               continue;
            }
         }
         _loc5_.sort(_sort);
         return _loc5_;
      }
      
      public function getHeroList(param1:GearItemDescription) : Vector.<HeroEntryValueObject>
      {
         var _loc3_:* = null;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc9_:int = 0;
         var _loc2_:Vector.<PlayerHeroWatcherEntry> = new Vector.<PlayerHeroWatcherEntry>();
         var _loc12_:int = 0;
         var _loc11_:* = parent.dict;
         for(var _loc7_ in parent.dict)
         {
            _loc3_ = parent.dict[_loc7_];
            _loc10_ = _loc3_.itemsNeeded.length;
            _loc8_ = 0;
            while(_loc8_ < _loc10_)
            {
               _loc6_ = _loc3_.itemsNeeded[_loc8_];
               if(_loc6_ == param1)
               {
                  if(_loc2_.indexOf(_loc3_) == -1)
                  {
                     _loc2_.push(_loc3_);
                  }
               }
               if(_loc6_.craftRecipe)
               {
                  if(_loc6_.craftRecipe.fullList.indexOf(param1) != -1)
                  {
                     if(_loc2_.indexOf(_loc3_) == -1)
                     {
                        _loc2_.push(_loc3_);
                     }
                  }
               }
               _loc8_++;
            }
         }
         var _loc5_:Vector.<HeroEntryValueObject> = new Vector.<HeroEntryValueObject>();
         var _loc4_:int = _loc2_.length;
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            _loc3_ = _loc2_[_loc9_];
            _loc5_.push(new HeroEntryValueObject(_loc3_.hero,_loc3_.playerEntry));
            _loc9_++;
         }
         return _loc5_;
      }
      
      public function validate() : void
      {
      }
      
      private function _sort(param1:HeroEntryValueObject, param2:HeroEntryValueObject) : int
      {
         return param2.getPower() - param1.getPower();
      }
   }
}
