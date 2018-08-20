package game.view.gui.clanscreen.heroes
{
   import flash.geom.Point;
   import game.assets.HeroRsxAssetDisposable;
   import game.assets.IHeroAsset;
   import game.battle.view.BattleScene;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.Player;
   import game.view.gui.components.HeroPreview;
   import game.view.gui.homescreen.PlayerActiveHeroesProvider;
   import game.view.hero.FreeClanHero;
   import game.view.hero.FreeHero;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.TouchEvent;
   
   public class ClanScreenHeroes
   {
      
      public static var lastDebugInstance:ClanScreenHeroes;
       
      
      private var player:Player;
      
      private var heroesProvider:PlayerActiveHeroesProvider;
      
      private var titansProvider:PlayerActiveHeroesProvider;
      
      private var map:FreeHeroWalkMap;
      
      private var scene:BattleScene;
      
      private var mightyTitan:HeroPreview;
      
      private var heroes:Vector.<FreeHero>;
      
      private var titans:Vector.<FreeHero>;
      
      public function ClanScreenHeroes()
      {
         map = new FreeHeroWalkMap();
         scene = new BattleScene();
         mightyTitan = new HeroPreview();
         heroes = new Vector.<FreeHero>();
         titans = new Vector.<FreeHero>();
         super();
         lastDebugInstance = this;
         map.boundaries.push(new Circle(0,0,300));
         map.obstacles.push(new Circle(0,0,160));
         map.obstacles.push(new Circle(0,-250,80));
         mightyTitan.graphics.scaleY = 0.75 * 0.7;
         mightyTitan.graphics.scaleX = -mightyTitan.graphics.scaleY;
         mightyTitan.graphics.touchable = false;
         Starling.current.stage.addEventListener("touch",handler_touch);
         heroesProvider = new PlayerActiveHeroesProvider(false,3,0.5);
         heroesProvider.signal_updateHeroes.add(handler_updateHeroes);
         titansProvider = new PlayerActiveHeroesProvider(true,3);
         titansProvider.signal_updateHeroes.add(handler_updateTitans);
      }
      
      public function dispose() : void
      {
         if(heroesProvider)
         {
            heroesProvider.signal_updateHeroes.remove(handler_updateHeroes);
            heroesProvider.dispose();
         }
         if(titansProvider)
         {
            titansProvider.signal_updateHeroes.remove(handler_updateHeroes);
            titansProvider.dispose();
         }
         Starling.current.stage.removeEventListener("touch",handler_touch);
      }
      
      public function get graphics() : DisplayObjectContainer
      {
         return scene.animationTarget;
      }
      
      public function get mightyTitanGraphics() : DisplayObject
      {
         return mightyTitan.graphics;
      }
      
      public function restart(param1:Player) : void
      {
         handler_updateHeroes(new Vector.<HeroRsxAssetDisposable>(),new Vector.<UnitDescription>());
         handler_updateTitans(new Vector.<HeroRsxAssetDisposable>(),new Vector.<UnitDescription>());
         heroesProvider.restart();
         titansProvider.restart();
      }
      
      public function start(param1:Player) : void
      {
         heroesProvider.start(param1);
         titansProvider.start(param1);
      }
      
      public function advanceTime(param1:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function updateHeroes(param1:Vector.<HeroRsxAssetDisposable>, param2:Vector.<UnitDescription>, param3:Boolean) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function relaxHeroes() : void
      {
         var _loc5_:int = 0;
         var _loc11_:* = NaN;
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc10_:int = 0;
         var _loc7_:* = null;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc1_:Vector.<FreeHero> = heroes.concat(titans);
         _loc5_ = 0;
         while(_loc5_ < 30)
         {
            _loc11_ = 0;
            _loc12_ = _loc1_.length;
            _loc9_ = 0;
            while(_loc9_ < _loc12_ - 1)
            {
               _loc8_ = _loc1_[_loc9_];
               _loc10_ = _loc9_ + 1;
               while(_loc10_ < _loc12_)
               {
                  _loc7_ = _loc1_[_loc10_];
                  _loc4_ = _loc7_.position.x - _loc8_.position.x;
                  _loc6_ = _loc7_.position.y - _loc8_.position.y;
                  _loc2_ = Math.sqrt(_loc4_ * _loc4_ + _loc6_ * _loc6_);
                  _loc4_ = _loc4_ / _loc2_;
                  _loc6_ = _loc6_ / _loc2_;
                  _loc2_ = _loc2_ - (_loc8_.view.position.size + _loc7_.view.position.size);
                  if(_loc2_ < 0)
                  {
                     _loc2_ = -_loc2_;
                     _loc11_ = Number(_loc11_ + _loc2_);
                     _loc7_.position.x = _loc7_.position.x + _loc4_ * _loc2_ * 0.5;
                     _loc7_.position.y = _loc7_.position.y + _loc6_ * _loc2_ * 0.5;
                     _loc8_.position.x = _loc8_.position.x - _loc4_ * _loc2_ * 0.5;
                     _loc8_.position.y = _loc8_.position.y - _loc6_ * _loc2_ * 0.5;
                  }
                  _loc10_++;
               }
               _loc9_++;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc12_ - 1)
            {
               _loc8_ = _loc1_[_loc9_];
               var _loc14_:int = 0;
               var _loc13_:* = map.obstacles;
               for each(var _loc3_ in map.obstacles)
               {
                  _loc4_ = _loc8_.position.x - _loc3_.x;
                  _loc6_ = _loc8_.position.y - _loc3_.y;
                  _loc2_ = Math.sqrt(_loc4_ * _loc4_ + _loc6_ * _loc6_);
                  _loc4_ = _loc4_ / _loc2_;
                  _loc6_ = _loc6_ / _loc2_;
                  if(_loc2_ < _loc3_.r + _loc8_.view.position.size)
                  {
                     _loc2_ = _loc3_.r + _loc8_.view.position.size - _loc2_;
                     _loc11_ = Number(_loc11_ + _loc2_);
                     _loc8_.position.x = _loc8_.position.x + _loc4_ * _loc2_;
                     _loc8_.position.y = _loc8_.position.y + _loc6_ * _loc2_;
                  }
               }
               var _loc16_:int = 0;
               var _loc15_:* = map.boundaries;
               for each(_loc3_ in map.boundaries)
               {
                  _loc4_ = _loc8_.position.x - _loc3_.x;
                  _loc6_ = _loc8_.position.y - _loc3_.y;
                  _loc2_ = Math.sqrt(_loc4_ * _loc4_ + _loc6_ * _loc6_);
                  _loc4_ = _loc4_ / _loc2_;
                  _loc6_ = _loc6_ / _loc2_;
                  if(_loc2_ > _loc3_.r - _loc8_.view.position.size)
                  {
                     _loc2_ = _loc2_ - (_loc3_.r - _loc8_.view.position.size);
                     _loc11_ = Number(_loc11_ + _loc2_);
                     _loc8_.position.x = _loc8_.position.x - _loc4_ * _loc2_;
                     _loc8_.position.y = _loc8_.position.y - _loc6_ * _loc2_;
                  }
               }
               _loc9_++;
            }
            if(_loc11_ < 1)
            {
               return;
            }
            _loc5_++;
         }
      }
      
      private function createNewHero(param1:IHeroAsset, param2:UnitDescription, param3:Boolean = false) : void
      {
         var _loc4_:* = 60;
         if(!param3)
         {
            _loc4_ = 20;
         }
         var _loc5_:FreeHero = new FreeClanHero(param3);
         var _loc6_:Point = map.getRandomPosition(_loc4_);
         _loc5_.setPosition(_loc6_.x,_loc6_.y);
         _loc5_.view.position.size = _loc4_;
         _loc5_.view.position.direction = _loc6_.x < 0?1:-1;
         _loc5_.init(param1);
         scene.addHeroView(null,_loc5_.view);
         if(!param3)
         {
            heroes.push(_loc5_);
         }
         else
         {
            titans.push(_loc5_);
         }
      }
      
      private function handler_touch(param1:TouchEvent) : void
      {
      }
      
      private function handler_updateHeroes(param1:Vector.<HeroRsxAssetDisposable>, param2:Vector.<UnitDescription>) : void
      {
         updateHeroes(param1,param2,false);
      }
      
      private function handler_updateTitans(param1:Vector.<HeroRsxAssetDisposable>, param2:Vector.<UnitDescription>) : void
      {
         var _loc3_:IHeroAsset = param1.shift();
         var _loc4_:UnitDescription = param2.shift();
         if(_loc4_ != null)
         {
            mightyTitan.loadHero(_loc4_);
         }
         updateHeroes(param1,param2,true);
      }
   }
}
