package game.battle.view.hero
{
   import game.assets.storage.AssetStorage;
   import game.battle.gui.BattleHpBarClip;
   
   public class HeroViewEnergyBar
   {
       
      
      private const maxValue:Number = 1000;
      
      private var bar:BattleHpBarClip;
      
      private var statusBar:HeroStatusOverlay;
      
      public function HeroViewEnergyBar(param1:HeroStatusOverlay, param2:Number)
      {
         bar = AssetStorage.rsx.battle_interface.create_battleBarYellow();
         super();
         this.statusBar = param1;
         bar.defineMaxValue(1000);
         setValue(param2);
         param1.addBar(bar);
      }
      
      public function dispose() : void
      {
         statusBar.removeBar(bar);
         bar.dispose();
      }
      
      public function setValue(param1:Number) : void
      {
         bar.setValue(param1 / 1000,1000 / 1000);
      }
   }
}
