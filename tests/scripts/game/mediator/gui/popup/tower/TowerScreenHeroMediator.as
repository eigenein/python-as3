package game.mediator.gui.popup.tower
{
   import game.assets.HeroRsxAssetDisposable;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.popup.tower.screen.TowerScreenHeroes;
   import starling.core.Starling;
   
   public class TowerScreenHeroMediator
   {
       
      
      private var player:Player;
      
      private var _towerScreenHero:TowerScreenHeroes;
      
      public function TowerScreenHeroMediator(param1:Player)
      {
         super();
         this.player = param1;
         _towerScreenHero = new TowerScreenHeroes(this);
         _towerScreenHero.init();
         param1.heroes.signal_heroChangeSkin.add(handler_heroChangeSkin);
         Starling.juggler.add(_towerScreenHero);
      }
      
      public function dispose() : void
      {
         Starling.juggler.remove(_towerScreenHero);
         player.heroes.signal_heroChangeSkin.remove(handler_heroChangeSkin);
         _towerScreenHero.dispose();
      }
      
      public function get towerScreenHero() : TowerScreenHeroes
      {
         return _towerScreenHero;
      }
      
      public function updateTeam() : void
      {
         _towerScreenHero.update();
      }
      
      public function getHeroAsset() : Vector.<HeroRsxAssetDisposable>
      {
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Vector.<HeroRsxAssetDisposable> = new Vector.<HeroRsxAssetDisposable>();
         var _loc3_:Vector.<UnitDescription> = player.tower.getActiveHeroes(player);
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_ = player.heroes.getById(_loc3_[_loc5_].id);
            _loc2_.push(AssetStorage.hero.getClipProvider(_loc1_.id,_loc1_.currentSkin));
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function handler_heroChangeSkin(param1:PlayerHeroEntry, param2:SkinDescription) : void
      {
         updateTeam();
      }
   }
}
