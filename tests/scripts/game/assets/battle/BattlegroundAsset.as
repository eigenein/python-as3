package game.assets.battle
{
   import engine.core.assets.AssetProvider;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   
   public class BattlegroundAsset extends RsxGameAsset
   {
       
      
      private var _mapGuiMarker:String;
      
      private var _mainClip:String;
      
      private var _noScrolling:Boolean;
      
      private var _fogOfDepth:AssetClipLink;
      
      private var _sideOffset:int;
      
      private var _animatedLayers:AssetClipLink;
      
      public function BattlegroundAsset(param1:*)
      {
         super(param1);
         _mapGuiMarker = param1.mapGuiMarker;
         _mainClip = param1.mainClip;
         _noScrolling = param1.noScrolling;
         if(param1.data)
         {
            if(param1.data.fogOfDepth)
            {
               _fogOfDepth = new AssetClipLink(AssetStorage.rsx.getByName(param1.data.fogOfDepth.asset),param1.data.fogOfDepth.clip);
            }
            if(param1.data.animatedLayers)
            {
               _animatedLayers = new AssetClipLink(AssetStorage.rsx.getByName(param1.data.animatedLayers.asset),param1.data.animatedLayers.clip);
            }
            _sideOffset = int(param1.data.sideOffset);
         }
      }
      
      public function get mapGuiMarker() : String
      {
         return _mapGuiMarker;
      }
      
      public function get mainClip() : String
      {
         return _mainClip;
      }
      
      public function get noScrolling() : Boolean
      {
         return _noScrolling;
      }
      
      public function get internalName() : String
      {
         return file.fileName.replace(".rsx","");
      }
      
      public function get fogOfDepth() : AssetClipLink
      {
         return _fogOfDepth;
      }
      
      public function get sideOffset() : int
      {
         return _sideOffset;
      }
      
      public function get animatedLayers() : AssetClipLink
      {
         return _animatedLayers;
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         var _loc2_:Array = [file];
         if(_fogOfDepth)
         {
            _loc2_.push(_fogOfDepth.asset);
         }
         if(_animatedLayers)
         {
            _loc2_.push(_animatedLayers.asset);
         }
         param1.request(this,_loc2_);
      }
   }
}
