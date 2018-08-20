package game.battle.controller.hero
{
   import battle.data.BattleHeroDescription;
   import battle.proxy.idents.SwitchHeroAssetIdent;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.hero.HeroView;
   
   public class SwitchHeroAssetManager
   {
       
      
      private var view:HeroView;
      
      private var graphics:BattleGraphicsMethodProvider;
      
      private var defaultHero:BattleHeroDescription;
      
      private var defaultPrefix:String;
      
      private var currentHero:BattleHeroDescription;
      
      private var currentPrefix:String;
      
      private var temporaryAsset:SwitchHeroAssetIdent;
      
      public function SwitchHeroAssetManager(param1:HeroView, param2:BattleGraphicsMethodProvider, param3:BattleHeroDescription)
      {
         super();
         this.view = param1;
         this.graphics = param2;
         this.defaultHero = param3;
         defaultPrefix = "";
      }
      
      public function setDefault(param1:SwitchHeroAssetIdent) : void
      {
         if(param1.heroDescription != null)
         {
            defaultHero = param1.heroDescription;
         }
         if(param1.prefix != null)
         {
            defaultPrefix = param1.prefix;
         }
         update();
      }
      
      public function setTemporary(param1:SwitchHeroAssetIdent) : void
      {
         temporaryAsset = param1;
         update();
      }
      
      public function die() : void
      {
         if(temporaryAsset != null)
         {
            if(temporaryAsset.doRemoveOnDeath)
            {
               temporaryAsset = null;
               update();
            }
         }
      }
      
      public function enemyTeamEmpty() : void
      {
         if(temporaryAsset != null)
         {
            if(temporaryAsset.doRemoveOnEnemyTeamEmpty)
            {
               temporaryAsset = null;
               update();
            }
         }
      }
      
      protected function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(temporaryAsset && temporaryAsset.heroDescription != null)
         {
            _loc1_ = temporaryAsset.heroDescription;
         }
         else
         {
            _loc1_ = defaultHero;
         }
         if(temporaryAsset && temporaryAsset.prefix != null)
         {
            _loc2_ = temporaryAsset.prefix;
         }
         else
         {
            _loc2_ = defaultPrefix;
         }
         if(_loc1_ != currentHero || _loc2_ != currentPrefix)
         {
            currentHero = _loc1_;
            currentPrefix = _loc2_;
            view.applyAsset(graphics.getHeroAsset(currentHero,1,currentPrefix));
         }
      }
   }
}
