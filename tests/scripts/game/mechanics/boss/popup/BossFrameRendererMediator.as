package game.mechanics.boss.popup
{
   import game.assets.storage.AssetStorage;
   import game.command.intern.OpenHeroPopUpCommand;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.CoinDescription;
   import game.mechanics.boss.mediator.BossRecommendedHeroValueObject;
   import game.mechanics.boss.mediator.BossRecommendedHeroesListPopupMediator;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.user.Player;
   import starling.textures.Texture;
   
   public class BossFrameRendererMediator
   {
       
      
      private var player:Player;
      
      private var boss:BossTypeDescription;
      
      public function BossFrameRendererMediator(param1:Player, param2:BossTypeDescription)
      {
         super();
         this.player = param1;
         this.boss = param2;
      }
      
      public function getBossIcon(param1:BossTypeDescription) : Texture
      {
         return AssetStorage.rsx.boss_icons.getTexture(param1.iconAssetTexture);
      }
      
      public function getBossCoinIcon(param1:BossTypeDescription) : Texture
      {
         return AssetStorage.inventory.getItemGUIIconTexture(DataStorage.coin.getById(param1.coinId) as CoinDescription);
      }
      
      public function getBossCoinName(param1:BossTypeDescription) : String
      {
         return (DataStorage.coin.getById(param1.coinId) as CoinDescription).name;
      }
      
      public function getRecommendedHeroes(param1:BossTypeDescription) : Vector.<BossRecommendedHeroValueObject>
      {
         var _loc2_:Vector.<BossRecommendedHeroValueObject> = new Vector.<BossRecommendedHeroValueObject>();
         var _loc5_:int = 0;
         var _loc4_:* = param1.recommendedHeroes;
         for each(var _loc3_ in param1.recommendedHeroes)
         {
            _loc2_.push(new BossRecommendedHeroValueObject(_loc3_,player.heroes.getById(_loc3_.id)));
         }
         _loc2_.sort(BossRecommendedHeroValueObject.sort_byFragments);
         return _loc2_.slice(0,5);
      }
      
      public function action_recommended(param1:BossTypeDescription) : void
      {
         var _loc2_:BossRecommendedHeroesListPopupMediator = new BossRecommendedHeroesListPopupMediator(player,param1);
         _loc2_.open();
      }
      
      public function action_hero(param1:HeroEntryValueObject) : void
      {
         var _loc2_:OpenHeroPopUpCommand = new OpenHeroPopUpCommand(player,param1.hero,null);
         _loc2_.execute();
      }
   }
}
