package game.battle.view.text
{
   import com.progrestar.common.lang.Translate;
   import game.battle.controller.entities.BattleHero;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.BattleScene;
   import game.battle.view.hero.HeroView;
   
   public class BattleGraphicsTextMethodProvider
   {
       
      
      private var missText:String;
      
      private var dodgeText:String;
      
      private var immuneText:String;
      
      private var blockText:String;
      
      private var redirectText:String;
      
      private var graphics:BattleGraphicsMethodProvider;
      
      private var scene:BattleScene;
      
      public function BattleGraphicsTextMethodProvider(param1:BattleGraphicsMethodProvider)
      {
         missText = Translate.translate("UI_BATTLE_MISS");
         dodgeText = Translate.translate("UI_BATTLE_DODGE");
         immuneText = Translate.translate("UI_BATTLE_IMMUNE");
         blockText = Translate.translate("UI_BATTLE_BLOCK");
         redirectText = Translate.translate("UI_BATTLE_REDIRECT");
         super();
         this.graphics = param1;
      }
      
      public function setScene(param1:BattleScene) : void
      {
         scene = param1;
      }
      
      public function energyDefault(param1:HeroView, param2:String, param3:Number) : void
      {
      }
      
      public function energyModified(param1:HeroView, param2:String, param3:Number) : void
      {
         graphics.createEnergyText(param1,param2,scene.textController.ENERGY,60,param3,false);
      }
      
      public function energyCanceled(param1:HeroView, param2:String, param3:Number) : void
      {
         graphics.createEnergyText(param1,param2,scene.textController.ENERGY,60,param3,true);
      }
      
      public function missed(param1:HeroView) : void
      {
         graphics.createText(param1,missText,scene.textController.MISSED);
      }
      
      public function dodged(param1:HeroView) : void
      {
         graphics.createText(param1,dodgeText,scene.textController.DODGED);
      }
      
      public function immune(param1:HeroView) : void
      {
         graphics.createText(param1,immuneText,scene.textController.DODGED);
      }
      
      public function block(param1:HeroView) : void
      {
         graphics.createText(param1,blockText,scene.textController.DODGED);
      }
      
      public function redirect(param1:HeroView) : void
      {
         graphics.createText(param1,redirectText,scene.textController.DODGED);
      }
      
      public function critDamagePhysical(param1:HeroView, param2:int, param3:String) : void
      {
         graphics.createText(param1,String(param2),scene.textController.CRIT_DAMAGE_PHYSICAL,param3);
      }
      
      public function critDamageMagic(param1:HeroView, param2:int, param3:String) : void
      {
         graphics.createText(param1,String(param2),scene.textController.CRIT_DAMAGE_MAGIC,param3);
      }
      
      public function damagePhysical(param1:HeroView, param2:int, param3:String) : void
      {
         graphics.createText(param1,String(param2),scene.textController.DAMAGE_PHYSICAL,param3);
      }
      
      public function damageMagic(param1:HeroView, param2:int, param3:String) : void
      {
         graphics.createText(param1,String(param2),scene.textController.DAMAGE_MAGIC,param3);
      }
      
      public function damagePure(param1:HeroView, param2:int, param3:String) : void
      {
         graphics.createText(param1,String(param2),scene.textController.DAMAGE_PURE,param3);
      }
      
      public function critDamagePure(param1:HeroView, param2:int, param3:String) : void
      {
         graphics.createText(param1,String(param2),scene.textController.CRIT_DAMAGE_PURE,param3);
      }
      
      public function heal(param1:HeroView, param2:int) : void
      {
         graphics.createText(param1,"+" + param2,scene.textController.HEAL);
      }
      
      public function debug(param1:HeroView, param2:String) : void
      {
         if(BattleHero.BATTLE_INSPECTOR)
         {
            graphics.createText(param1,param2,scene.textController.DEBUG);
         }
      }
   }
}
