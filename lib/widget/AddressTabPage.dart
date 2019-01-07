import 'package:flutter/material.dart';
import 'package:travel_friend/common/TextResources.dart';
import 'package:travel_friend/pages/mate/AddressDetailPage.dart';

class AddressTabPage {
  AddressTabPage({this.icon, this.text, this.detailPage, this.addressSelect});

  final IconData icon;
  final String text;
  final AddressDetailPage detailPage;
  final AddressSelect addressSelect;

  List<AddressTabPage> initClassify() {
    // 存储所有页面的列表
    List<AddressTabPage> _allPages = <AddressTabPage>[
      new AddressTabPage(
          text: TextResources.addressTabChina,
          detailPage: new AddressDetailPage(type: 0, addressSelect: addressSelect)),
      new AddressTabPage(
          text: TextResources.addressTabSea,
          detailPage: new AddressDetailPage(type: 1, addressSelect: addressSelect)),
    ];
    return _allPages;
  }
}
