package game.mediator.gui.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import game.data.reward.BundleRewardHeroInventoryItem;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.skin.SkinDescriptionLevel;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.SkinBundlePopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class GenericSkinBundlePopupMediator extends BundlePopupMediator
   {
       
      
      private var _hero:HeroDescription;
      
      private var _skinId:int;
      
      private var _statBonus:String;
      
      private var _assetClipName:String;
      
      public function GenericSkinBundlePopupMediator(param1:Player)
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         super(param1);
         var _loc4_:int = _reward.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(_reward[_loc6_] is BundleRewardHeroInventoryItem)
            {
               _loc3_ = _reward[_loc6_] as BundleRewardHeroInventoryItem;
               _skinId = _loc3_.bundleHeroReward.reward.id;
               _loc5_ = DataStorage.skin.getById(_skinId) as SkinDescription;
               _hero = DataStorage.hero.getHeroById(_loc5_.heroId);
               _loc2_ = _loc5_.levels[_loc5_.levels.length - 1];
               _loc7_ = _loc5_.levels[0];
               _statBonus = _loc2_.statBonus.name + ColorUtils.hexToRGBFormat(15007564) + ": +" + _loc7_.statBonus.value + "\n";
               _statBonus = _statBonus + (ColorUtils.hexToRGBFormat(16573879) + Translate.translateArgs("UI_POPUP_BUNDLE_SKIN_STAT_BONUS",ColorUtils.hexToRGBFormat(15007564) + " +" + _loc2_.statBonus.value));
               break;
            }
            _loc6_++;
         }
         switch(int(bundle.id) - 27)
         {
            case 0:
            case 1:
            case 2:
               _assetClipName = "dialog_bundle_skin_halloween";
         }
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get skinId() : int
      {
         return _skinId;
      }
      
      public function get statBonus() : String
      {
         return _statBonus;
      }
      
      public function get assetClipName() : String
      {
         return _assetClipName;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SkinBundlePopup(this);
         return _popup;
      }
   }
}
