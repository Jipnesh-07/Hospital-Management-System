//
//  LaboratoryContentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct LaboratoryContentView: View {
    @State private var isAddSheetPresented = false
    
    let labTests = [
        "Blood-Test": [
            "Blood Glucose Test",
            "Complete Blood Count (CBC)",
            "Lipid Profile Test",
            "Liver Function Test (LFT)",
            "Kidney Function Test",
            "Thyroid Function Test",
            "Hemoglobin A1c Test",
            "Rheumatoid Factor Test",
            "Autoimmune Antibody Tests",
            "Antinuclear Antibody (ANA) Test",
            "Cortisol Test",
            "Thyroid Antibody Tests",
            "Glucose Tolerance Test",
            "Lactose Intolerance Test"
        ],
        "X-Ray": [
            "Chest X-Ray",
            "Abdominal X-Ray",
            "Skeletal X-Ray",
            "Dental X-Ray",
            "Extremity X-Ray (e.g., Ankle, Wrist)"
        ],
        "MRI": [
            "Brain MRI",
            "Spine MRI",
            "Joint MRI (e.g., Knee, Shoulder)",
            "Pelvic MRI"
        ],
        "CT-Scan": [
            "Head CT Scan",
            "Abdominal CT Scan",
            "Chest CT Scan",
            "Pelvic CT Scan"
        ],
        "Endoscopic Procedures": [
            "Endoscopy",
            "Colonoscopy",
            "Cystoscopy",
            "Laryngoscopy",
            "Bronchoscopy"
        ],
        "Cardiac-Tests": [
            "Electrocardiogram (ECG or EKG)",
            "Echocardiogram",
            "Cardiac Stress Test",
            "Holter Monitor Test"
        ],
        "Pregnancy Tests": [
            "Ultrasound",
            "Obstetric Ultrasound",
            "Doppler Ultrasound",
            "Nuchal Translucency Test"
        ],
        "Cancer Screening": [
            "Mammogram",
            "Pap Smear Test",
            "Prostate Specific Antigen (PSA) Test",
            "Colon Cancer Screening (e.g., Colonoscopy, Fecal Occult Blood Test)"
        ],
        "Neurological Tests": [
            "Electroencephalogram (EEG)",
            "Nerve Conduction Study (NCS)",
            "Electromyography (EMG)",
            "Visual Evoked Potential (VEP) Test"
        ]
    ]
    
    var body: some View {
        NavigationView {
            List(labTests.keys.sorted(), id: \.self) { category in
                NavigationLink(destination: TestDetailView(tests: self.labTests[category] ?? [])) {
                    Text(category)
                }
            }
            .navigationTitle("Lab Tests")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddSheetPresented = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddSheetPresented) {
                BookLabAppointmentsView()
            }
        }
        
    }
}

struct TestDetailView: View {
    let tests: [String]
    
    var body: some View {
        List(tests, id: \.self) { test in
            Text(test)
        }
        .navigationTitle("Tests")
    }
}

#Preview {
    LaboratoryContentView()
}




