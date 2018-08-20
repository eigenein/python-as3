package game.mechanics.expedition.storage
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DescriptionBase;
   
   public class ExpeditionStoryDescription extends DescriptionBase
   {
       
      
      private var _slotId:int;
      
      private var _assetScale:Number;
      
      private var _unitId:int;
      
      private var _isHero:Boolean;
      
      private var _isValkyrie:Boolean;
      
      public function ExpeditionStoryDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _unitId = param1.unitId;
         _assetScale = param1.assetScale;
         _slotId = param1.slot;
         _isHero = param1.isHero;
         _isValkyrie = param1.isValkyrie;
      }
      
      public function get slotId() : int
      {
         return _slotId;
      }
      
      public function get assetScale() : Number
      {
         return _assetScale;
      }
      
      public function get unitId() : int
      {
         return _unitId;
      }
      
      public function get desc_before() : String
      {
         return Translate.translate("LIB_EXPEDITION_STORY_DESC_BEFORE_" + id);
      }
      
      public function get desc_after() : String
      {
         return Translate.translate("LIB_EXPEDITION_STORY_DESC_AFTER_" + id);
      }
      
      public function get title() : String
      {
         return Translate.translate("LIB_EXPEDITION_STORY_NAME_" + id);
      }
      
      public function get location() : String
      {
         return Translate.translate("LIB_EXPEDITION_STORY_LOCATION_NAME_SUB_" + id) + ", " + Translate.translate("LIB_EXPEDITION_STORY_LOCATION_NAME_BASE_" + _slotId);
      }
      
      override public function get name() : String
      {
         return title;
      }
      
      public function get isHero() : Boolean
      {
         return _isHero;
      }
      
      public function get isValkyrie() : Boolean
      {
         return _isValkyrie;
      }
   }
}
