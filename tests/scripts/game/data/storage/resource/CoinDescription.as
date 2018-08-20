package game.data.storage.resource
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.enum.lib.InventoryItemType;
   
   public class CoinDescription extends InventoryItemDescription implements IObtainableResource
   {
      
      public static const GUILD:String = "guild";
      
      public static const TOWER:String = "tower";
      
      public static const SKULL:String = "skull";
      
      public static const ARENA:String = "arena";
      
      public static const GRAND_ARENA:String = "grand_arena";
      
      public static const SUMMON_KEY:String = "summon_key";
      
      public static const ARTIFACT_COIN:String = "artifact_coin";
      
      public static const NY_GIFT_COIN:String = "ny_gift_coin";
      
      public static const NY_TREE_COIN:String = "ny_tree_coin";
      
      public static const CLAN_WAR_BRONZE:String = "gvg_bronze";
      
      public static const CLAN_WAR_SILVER:String = "gvg_silver";
      
      public static const CLAN_WAR_GOLD:String = "gvg_gold";
      
      public static const TITAN_ARENA_COIN:String = "titan_arena";
      
      public static const TITAN_ARENA_TOKEN:String = "titan_token";
       
      
      public var ident:String;
      
      private var _obtainNavigatorType:ObtainNavigatorType;
      
      public function CoinDescription(param1:Object)
      {
         super(InventoryItemType.COIN,param1);
         ident = param1.ident;
         _obtainNavigatorType = new ObtainNavigatorType(param1.obtainNavigatorData);
      }
      
      public function get obtainNavigatorType() : ObtainNavigatorType
      {
         return _obtainNavigatorType;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_COIN_NAME_" + id);
         _descText = Translate.translate("LIB_COIN_DESC_" + id);
      }
   }
}
