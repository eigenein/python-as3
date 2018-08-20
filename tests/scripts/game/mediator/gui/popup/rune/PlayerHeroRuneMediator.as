package game.mediator.gui.popup.rune
{
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.rune.RuneTierDescription;
   import game.data.storage.rune.RuneTypeDescription;
   import game.model.GameModel;
   import game.model.user.hero.PlayerHeroEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerHeroRuneMediator
   {
       
      
      private var _hero:PlayerHeroEntry;
      
      public const signal_updated:Signal = new Signal();
      
      public const runes:Vector.<PlayerHeroRuneValueObject> = new Vector.<PlayerHeroRuneValueObject>();
      
      public function PlayerHeroRuneMediator()
      {
         super();
      }
      
      public function get runesAvailable() : Boolean
      {
         return GameModel.instance.player.clan.clan;
      }
      
      public function get runesEnabled() : Boolean
      {
         return MechanicStorage.ENCHANT.enabled;
      }
      
      public function get runesAvailableByTeamLevel() : Boolean
      {
         return GameModel.instance.player.levelData.level.level >= MechanicStorage.ENCHANT.teamLevel;
      }
      
      public function get availableFromTeamLevel() : int
      {
         return MechanicStorage.ENCHANT.teamLevel;
      }
      
      public function setHero(param1:PlayerHeroEntry) : void
      {
         var _loc2_:* = undefined;
         if(_hero)
         {
            _hero.signal_levelUp.remove(handler_levelUpdated);
            _hero.runes.signal_runeUpdated.remove(handler_runeUpdated);
         }
         if(param1)
         {
            _loc2_ = param1.hero.getRunes();
            var _loc5_:int = 0;
            var _loc4_:* = _loc2_;
            for(var _loc3_ in _loc2_)
            {
               runes[_loc3_] = new PlayerHeroRuneValueObject(param1,_loc3_,_loc2_[_loc3_]);
            }
            _hero = param1;
            _hero.signal_levelUp.add(handler_levelUpdated);
            _hero.runes.signal_runeUpdated.add(handler_runeUpdated);
         }
         else
         {
            var _loc7_:int = 0;
            var _loc6_:* = runes;
            for(_loc3_ in runes)
            {
               runes[_loc3_] = null;
            }
            _hero = null;
         }
         signal_updated.dispatch();
      }
      
      private function handler_runeUpdated(param1:RuneTierDescription) : void
      {
         signal_updated.dispatch();
      }
      
      private function handler_levelUpdated(param1:PlayerHeroEntry) : void
      {
         signal_updated.dispatch();
      }
   }
}
