package game.view.gui.homescreen
{
   import game.assets.HeroRsxAssetDisposable;
   import game.battle.controller.FreeHeroController;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.Player;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   
   public class HomeScreenHeroes implements IAnimatable
   {
       
      
      private var player:Player;
      
      private var heroesProvider:PlayerActiveHeroesProvider;
      
      private var _activeHeroes:Vector.<UnitDescription>;
      
      private var _controller:FreeHeroController;
      
      public function HomeScreenHeroes(param1:Player)
      {
         _activeHeroes = new Vector.<UnitDescription>();
         super();
         this.player = param1;
         var _loc2_:Number = Starling.current.stage.stageWidth;
         var _loc3_:* = _loc2_;
         _controller = new FreeHeroController(_loc3_,_loc2_);
         heroesProvider = new PlayerActiveHeroesProvider(false,5);
         heroesProvider.signal_updateHeroes.add(handler_updateHeroes);
         heroesProvider.start(param1);
      }
      
      public function dispose() : void
      {
         if(heroesProvider)
         {
            heroesProvider.dispose();
         }
      }
      
      public function get container() : DisplayObjectContainer
      {
         return _controller.graphics;
      }
      
      public function get activeHeroes() : Vector.<UnitDescription>
      {
         return _activeHeroes;
      }
      
      public function advanceTime(param1:Number) : void
      {
         _controller.advanceTime(param1);
      }
      
      public function get controller() : FreeHeroController
      {
         return _controller;
      }
      
      private function handler_updateHeroes(param1:Vector.<HeroRsxAssetDisposable>, param2:Vector.<UnitDescription>) : void
      {
         _activeHeroes = param2;
         _controller.initialize(param1,param2);
      }
   }
}
