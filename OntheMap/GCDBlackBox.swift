//
//  GCDBlackBox.swift
//  OntheMap
//
//  Created by Apple on 03/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

func performUIUpdateOnMain(_ update: @escaping () -> Void) {
    DispatchQueue.main.async {
        update()
    }
}
