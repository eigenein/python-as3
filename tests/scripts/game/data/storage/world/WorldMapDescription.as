package game.data.storage.world
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DescriptionBase;
   
   public class WorldMapDescription extends DescriptionBase
   {
       
      
      private var _assetFile:String;
      
      private var _assetClass:String;
      
      private var _nameShort:String;
      
      private var _nameFull:String;
      
      private var _teamLevel:int;
      
      public function WorldMapDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _assetClass = param1.assetClass;
         _assetFile = param1.assetFile;
         _teamLevel = param1.teamLevel;
      }
      
      public function get assetFile() : String
      {
         return _assetFile;
      }
      
      public function get assetClass() : String
      {
         return _assetClass;
      }
      
      public function get nameShort() : String
      {
         return _nameShort;
      }
      
      public function get nameFull() : String
      {
         return _nameFull;
      }
      
      public function get teamLevel() : int
      {
         return _teamLevel;
      }
      
      override public function applyLocale() : void
      {
         _nameShort = Translate.translateArgs("UI_COMMON_CHAPTER_NUMBER",id);
         _name = Translate.translate("LIB_WORLD_" + id);
         _nameFull = _nameShort + ": " + _name;
      }
   }
}
