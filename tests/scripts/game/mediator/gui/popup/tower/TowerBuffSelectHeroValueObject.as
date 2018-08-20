package game.mediator.gui.popup.tower
{
   import game.data.storage.DataStorage;
   import game.data.storage.tower.TowerBuffDescription;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.tower.TowerHeroState;
   import idv.cjcat.signals.Signal;
   
   public class TowerBuffSelectHeroValueObject extends PlayerHeroListValueObject
   {
       
      
      private var state:TowerHeroState;
      
      private var buff:TowerBuffDescription;
      
      public const signal_tweenState:Signal = new Signal();
      
      public function TowerBuffSelectHeroValueObject(param1:PlayerHeroEntry, param2:Player, param3:TowerHeroState)
      {
         super(param1.hero,param2);
         this.state = param3;
         signal_tweenState.add(updateState);
      }
      
      public function get relativeHp() : Number
      {
         if(empty)
         {
            return 0;
         }
         if(!state)
         {
            return 1;
         }
         return state.hp / state.maxHp;
      }
      
      public function get relativeEnergy() : Number
      {
         if(empty)
         {
            return 0;
         }
         if(!state)
         {
            return 0;
         }
         return state.energy / DataStorage.battleConfig.pve.defaultMaxEnergy;
      }
      
      public function get isDead() : Boolean
      {
         return !!state?state.isDead:false;
      }
      
      public function get isAvailable() : Boolean
      {
         var _loc1_:* = buff.effect.effect;
         if("hp" !== _loc1_)
         {
            if("energy" !== _loc1_)
            {
               if("resurrection" !== _loc1_)
               {
                  return false;
               }
               return state != null && (state.isDead || state.hp < state.maxHp);
            }
            return state == null || state.energy < DataStorage.battleConfig.pve.defaultMaxEnergy && !state.isDead;
         }
         return state != null && state.hp < state.maxHp && !state.isDead;
      }
      
      public function setAvailableByBuff(param1:TowerBuffDescription) : void
      {
         this.buff = param1;
      }
      
      private function updateState() : void
      {
         state = player.tower.heroes.getHeroState(_hero.id);
      }
   }
}
