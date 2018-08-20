package game.mediator.gui.popup.billing.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.skin.SkinDescriptionLevel;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TripleSkinBundleValueObject
   {
       
      
      private var _billingVO:BillingPopupValueObject;
      
      private var _signal_buy:Signal;
      
      private var _id:int;
      
      private var _skin:SkinDescription;
      
      private var _reward:Vector.<InventoryItem>;
      
      private var _hero:HeroDescription;
      
      private var _skinId:int;
      
      protected var _oldPrice:String;
      
      protected var _discountValue:int = 80;
      
      private var _statBonus:String;
      
      private var _skinName:String;
      
      private var _playerOwnsHero:BooleanPropertyWriteable;
      
      private var _playerOwnsSkin:BooleanPropertyWriteable;
      
      private var _getString_purchaseStatus:Boolean;
      
      public function TripleSkinBundleValueObject(param1:Object)
      {
         _signal_buy = new Signal(TripleSkinBundleValueObject);
         _playerOwnsHero = new BooleanPropertyWriteable();
         _playerOwnsSkin = new BooleanPropertyWriteable();
         super();
         parseRawData(param1);
      }
      
      public function get billingVO() : BillingPopupValueObject
      {
         return _billingVO;
      }
      
      public function get signal_buy() : Signal
      {
         return _signal_buy;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get skin() : SkinDescription
      {
         return _skin;
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _reward;
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get skinId() : int
      {
         return !!_skin?_skin.id:0;
      }
      
      public function get oldPrice() : String
      {
         if(!_billingVO)
         {
            return "";
         }
         var _loc3_:String = _billingVO.costString;
         var _loc2_:Array = _loc3_.split(" ");
         var _loc1_:Number = _loc2_[0];
         _loc1_ = _loc1_ * (100 / (100 - _discountValue));
         if(Math.round(_loc1_) != _loc1_)
         {
            return _loc1_.toFixed(2) + " " + _loc2_[1];
         }
         return _loc1_ + " " + _loc2_[1];
      }
      
      public function get costStrng() : String
      {
         return !!_billingVO?_billingVO.costString:"";
      }
      
      public function get discountValue() : int
      {
         return _discountValue;
      }
      
      public function get statBonus() : String
      {
         return _statBonus;
      }
      
      public function get skinName() : String
      {
         return _skinName;
      }
      
      public function get playerOwnsHero() : BooleanProperty
      {
         return _playerOwnsHero;
      }
      
      public function get playerOwnsSkin() : BooleanProperty
      {
         return _playerOwnsSkin;
      }
      
      public function get getString_purchaseStatus() : Boolean
      {
         return _getString_purchaseStatus;
      }
      
      public function updateBillingVO(param1:BillingPopupValueObject) : void
      {
         this._billingVO = param1;
      }
      
      public function updatePlayerData(param1:Player) : void
      {
         var _loc2_:PlayerHeroEntry = param1.heroes.getById(_hero.id);
         _playerOwnsHero.value = _loc2_ != null;
         _playerOwnsSkin.value = _playerOwnsHero.value && _loc2_.skinData.getSkinLevelByID(_skin.id) > 0 || param1.inventory.getFragmentCount(_skin) > 0;
      }
      
      public function parseRawData(param1:Object) : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc8_:* = 0;
         var _loc4_:* = null;
         _id = param1.id;
         _reward = new Vector.<InventoryItem>();
         var _loc5_:int = param1.reward.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = param1.reward[_loc7_];
            if(_loc3_.fragmentSkin)
            {
               _loc8_ = 0;
               var _loc11_:int = 0;
               var _loc10_:* = _loc3_.fragmentSkin;
               for(_loc8_ in _loc3_.fragmentSkin)
               {
               }
               _skin = DataStorage.skin.getById(_loc8_) as SkinDescription;
               _hero = DataStorage.hero.getById(_skin.heroId) as HeroDescription;
            }
            else
            {
               _loc4_ = new RewardData(_loc3_);
               _reward = _reward.concat(_loc4_.outputDisplay);
            }
            _loc7_++;
         }
         var _loc2_:SkinDescriptionLevel = skin.levels[skin.levels.length - 1];
         var _loc9_:SkinDescriptionLevel = skin.levels[0];
         _statBonus = _loc2_.statBonus.name + ColorUtils.hexToRGBFormat(15007564) + ": +" + _loc9_.statBonus.value + "\n";
         _statBonus = _statBonus + (ColorUtils.hexToRGBFormat(16573879) + Translate.translateArgs("UI_POPUP_BUNDLE_SKIN_STAT_BONUS",ColorUtils.hexToRGBFormat(15007564) + " +" + _loc2_.statBonus.value));
         _skinName = _hero.name + " - " + _skin.name;
      }
   }
}
