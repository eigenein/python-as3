package game.data.storage.tower
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.cost.CostData;
   import game.data.storage.DescriptionBase;
   import starling.textures.Texture;
   
   public class TowerBuffDescription extends DescriptionBase
   {
      
      public static const BUFF_TYPE_TEAM:String = "team";
      
      public static const BUFF_TYPE_HERO:String = "hero";
       
      
      public var effect:TowerBuffEffect;
      
      public var cost:CostData;
      
      public var type:String;
      
      public var assetAtlas:int;
      
      public var assetTexture:String;
      
      protected var _message:String;
      
      public function TowerBuffDescription(param1:*)
      {
         super();
         this._id = param1.id;
         this.effect = new TowerBuffEffect(param1.effect);
         this.cost = new CostData(param1.cost);
         this.type = param1.type;
         this.assetAtlas = param1.assetAtlas;
         this.assetTexture = param1.assetTexture;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.inventory.getTexture(assetAtlas,assetTexture);
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_TOWERBUFF_NAME_" + id);
         _descText = Translate.translateArgs("LIB_TOWERBUFF_DESC_" + id,int(effect.value));
         _message = Translate.translateArgs("LIB_TOWERBUFF_MESSAGE_" + id,int(effect.value));
      }
   }
}
